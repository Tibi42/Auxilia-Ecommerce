<?php

namespace App\Service;

use App\Entity\Order;
use Doctrine\ORM\EntityManagerInterface;
use Psr\Log\LoggerInterface;

/**
 * Service gérant les opérations sur les commandes
 */
class OrderService
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private LoggerInterface $logger
    ) {}

    /**
     * Marque une commande comme payée et décrémente le stock des produits
     * 
     * @param Order $order La commande à traiter
     * @param string|null $paymentIntentId L'identifiant du paiement Stripe
     */
    public function completePayment(Order $order, ?string $paymentIntentId = null): void
    {
        // Ne traiter que si la commande est en attente
        if ($order->getStatus() !== 'pending') {
            $this->logger->info('Order already processed or not pending', [
                'order_id' => $order->getId(),
                'status' => $order->getStatus()
            ]);
            return;
        }

        $this->entityManager->beginTransaction();
        try {
            $order->setStatus('paid');
            if ($paymentIntentId) {
                $order->setStripePaymentIntentId($paymentIntentId);
            }

            // Décrémenter le stock pour chaque article
            foreach ($order->getOrderItems() as $orderItem) {
                $product = $orderItem->getProduct();
                if ($product && $product->getStock() !== null) {
                    $newStock = $product->getStock() - $orderItem->getQuantity();
                    $product->setStock(max(0, $newStock));

                    $this->logger->info('Decrementing stock for product', [
                        'product_id' => $product->getId(),
                        'quantity' => $orderItem->getQuantity(),
                        'new_stock' => $product->getStock()
                    ]);
                }
            }

            $this->entityManager->flush();
            $this->entityManager->commit();

            $this->logger->info('Order marked as paid and stock updated', [
                'order_id' => $order->getId(),
                'payment_intent' => $paymentIntentId
            ]);
        } catch (\Exception $e) {
            $this->entityManager->rollback();
            $this->logger->error('Error completing payment for order', [
                'order_id' => $order->getId(),
                'error' => $e->getMessage()
            ]);
            throw $e;
        }
    }
}
