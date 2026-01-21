<?php

namespace App\Controller;

use App\Repository\OrderRepository;
use Doctrine\ORM\EntityManagerInterface;
use Psr\Log\LoggerInterface;
use Stripe\Exception\SignatureVerificationException;
use Stripe\Webhook;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

/**
 * Contrôleur gérant les webhooks Stripe
 * 
 * Ce contrôleur reçoit les événements envoyés par Stripe pour confirmer
 * les paiements de manière sécurisée côté serveur.
 */
class StripeWebhookController extends AbstractController
{
    public function __construct(
        private string $webhookSecret,
        private LoggerInterface $logger
    ) {
    }

    /**
     * Endpoint pour recevoir les webhooks Stripe
     * 
     * @param Request $request La requête HTTP contenant l'événement Stripe
     * @param OrderRepository $orderRepository Le repository des commandes
     * @param EntityManagerInterface $entityManager Le gestionnaire d'entités
     * @return Response
     */
    #[Route('/stripe/webhook', name: 'stripe_webhook', methods: ['POST'])]
    public function handleWebhook(
        Request $request,
        OrderRepository $orderRepository,
        EntityManagerInterface $entityManager
    ): Response {
        $payload = $request->getContent();
        $sigHeader = $request->headers->get('Stripe-Signature');

        if (!$sigHeader) {
            $this->logger->warning('Stripe webhook: Missing signature header');
            return new Response('Missing signature', Response::HTTP_BAD_REQUEST);
        }

        try {
            $event = Webhook::constructEvent(
                $payload,
                $sigHeader,
                $this->webhookSecret
            );
        } catch (SignatureVerificationException $e) {
            $this->logger->warning('Stripe webhook: Invalid signature', ['error' => $e->getMessage()]);
            return new Response('Invalid signature', Response::HTTP_BAD_REQUEST);
        } catch (\Exception $e) {
            $this->logger->error('Stripe webhook: Error parsing payload', ['error' => $e->getMessage()]);
            return new Response('Webhook error', Response::HTTP_BAD_REQUEST);
        }

        // Traitement des différents types d'événements
        switch ($event->type) {
            case 'checkout.session.completed':
                $this->handleCheckoutSessionCompleted($event->data->object, $orderRepository, $entityManager);
                break;

            case 'checkout.session.expired':
                $this->handleCheckoutSessionExpired($event->data->object, $orderRepository, $entityManager);
                break;

            case 'payment_intent.payment_failed':
                $this->handlePaymentFailed($event->data->object, $orderRepository, $entityManager);
                break;

            default:
                $this->logger->info('Stripe webhook: Unhandled event type', ['type' => $event->type]);
        }

        return new Response('OK', Response::HTTP_OK);
    }

    /**
     * Traite l'événement de session checkout complétée
     */
    private function handleCheckoutSessionCompleted(
        object $session,
        OrderRepository $orderRepository,
        EntityManagerInterface $entityManager
    ): void {
        $orderId = $session->metadata->order_id ?? null;

        if (!$orderId) {
            $this->logger->warning('Stripe webhook: No order_id in session metadata', ['session_id' => $session->id]);
            return;
        }

        $order = $orderRepository->find($orderId);

        if (!$order) {
            $this->logger->warning('Stripe webhook: Order not found', ['order_id' => $orderId]);
            return;
        }

        // Ne mettre à jour que si la commande est en attente
        if ($order->getStatus() === 'pending') {
            $order->setStatus('paid');
            $order->setStripePaymentIntentId($session->payment_intent);

            // Décrémenter le stock
            foreach ($order->getOrderItems() as $orderItem) {
                $product = $orderItem->getProduct();
                if ($product && $product->getStock() !== null) {
                    $newStock = $product->getStock() - $orderItem->getQuantity();
                    $product->setStock(max(0, $newStock)); // Éviter les stocks négatifs
                }
            }

            $entityManager->flush();

            $this->logger->info('Stripe webhook: Order marked as paid', [
                'order_id' => $orderId,
                'session_id' => $session->id
            ]);
        }
    }

    /**
     * Traite l'événement de session checkout expirée
     */
    private function handleCheckoutSessionExpired(
        object $session,
        OrderRepository $orderRepository,
        EntityManagerInterface $entityManager
    ): void {
        $orderId = $session->metadata->order_id ?? null;

        if (!$orderId) {
            return;
        }

        $order = $orderRepository->find($orderId);

        if ($order && $order->getStatus() === 'pending') {
            $order->setStatus('cancelled');
            $entityManager->flush();

            $this->logger->info('Stripe webhook: Order cancelled (session expired)', ['order_id' => $orderId]);
        }
    }

    /**
     * Traite l'événement d'échec de paiement
     */
    private function handlePaymentFailed(
        object $paymentIntent,
        OrderRepository $orderRepository,
        EntityManagerInterface $entityManager
    ): void {
        // Recherche de la commande par payment intent ID
        $order = $orderRepository->findOneBy(['stripePaymentIntentId' => $paymentIntent->id]);

        if ($order && $order->getStatus() === 'pending') {
            $order->setStatus('cancelled');
            $entityManager->flush();

            $this->logger->info('Stripe webhook: Order cancelled (payment failed)', [
                'order_id' => $order->getId(),
                'payment_intent' => $paymentIntent->id
            ]);
        }
    }
}
