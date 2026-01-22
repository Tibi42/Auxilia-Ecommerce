<?php

namespace App\Controller\Admin;

use App\Repository\OrderRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class OrderController extends AbstractController
{
    /**
     * Liste toutes les commandes de la boutique pour l'administration avec filtrage par statut
     * 
     * @param OrderRepository $orderRepository Le repository pour récupérer toutes les commandes
     * @param Request $request La requête HTTP entrante pour récupérer le filtre
     * @return Response Une instance de Response vers la liste des commandes admin
     */
    #[Route('/admin/orders', name: 'app_admin_orders')]
    public function index(OrderRepository $orderRepository, Request $request): Response
    {
        // Sécurité : Vérification explicite du rôle admin
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        // Récupère le paramètre de filtre statut depuis l'URL
        $selectedStatus = $request->query->get('status');

        // Récupère les commandes selon le filtre
        $orders = $orderRepository->findAllByStatus($selectedStatus);

        // Récupère tous les statuts distincts pour le filtre
        $statuses = $orderRepository->findDistinctStatuses();

        return $this->render('admin/order/index.html.twig', [
            'orders' => $orders,
            'statuses' => $statuses,
            'selectedStatus' => $selectedStatus,
        ]);
    }

    /**
     * Affiche les détails d'une commande spécifique pour l'administration
     * 
     * @param int $id L'identifiant de la commande
     * @param OrderRepository $orderRepository Le repository pour récupérer la commande
     * @return Response Une instance de Response vers la vue détaillée ou une redirection
     */
    #[Route('/admin/orders/{id}', name: 'app_admin_order_show')]
    public function show(int $id, OrderRepository $orderRepository): Response
    {
        // Sécurité : Vérification explicite du rôle admin
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        // Charge la commande avec ses orderItems explicitement pour éviter les problèmes de lazy loading
        $order = $orderRepository->createQueryBuilder('o')
            ->leftJoin('o.orderItems', 'oi')
            ->addSelect('oi')
            ->leftJoin('o.user', 'u')
            ->addSelect('u')
            ->where('o.id = :id')
            ->setParameter('id', $id)
            ->getQuery()
            ->getOneOrNullResult();

        if (!$order) {
            $this->addFlash('error', 'Commande introuvable.');
            return $this->redirectToRoute('app_admin_orders');
        }

        return $this->render('admin/order/show.html.twig', [
            'order' => $order,
        ]);
    }
    /**
     * Met à jour le statut d'une commande
     * 
     * @param int $id L'identifiant de la commande
     * @param Request $request La requête HTTP contenant le nouveau statut
     * @param OrderRepository $orderRepository Le repository pour récupérer la commande
     * @param \Doctrine\ORM\EntityManagerInterface $entityManager L'entity manager pour sauvegarder
     * @return Response Une redirection vers la page de détails
     */
    #[Route('/admin/orders/{id}/status', name: 'app_admin_order_status_update', methods: ['POST'])]
    public function updateStatus(int $id, Request $request, OrderRepository $orderRepository, \Doctrine\ORM\EntityManagerInterface $entityManager): Response
    {
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        // Sécurité : Validation du token CSRF
        if (!$this->isCsrfTokenValid('order-status-' . $id, $request->request->get('_token'))) {
            $this->addFlash('error', 'Jeton de sécurité invalide.');
            return $this->redirectToRoute('app_admin_orders');
        }

        $order = $orderRepository->find($id);

        if (!$order) {
            $this->addFlash('error', 'Commande introuvable.');
            return $this->redirectToRoute('app_admin_orders');
        }

        $newStatus = $request->request->get('status');

        // Liste des statuts valides (à synchroniser avec ceux utilisés ailleurs)
        $validStatuses = ['pending', 'paid', 'confirmed', 'shipped', 'delivered', 'cancelled'];

        if ($newStatus && in_array($newStatus, $validStatuses, true)) {
            $order->setStatus($newStatus);

            // Si le statut passe à 'shipped' et que la date n'est pas encore définie
            if ($newStatus === 'shipped' && !$order->getShippedAt()) {
                $order->setShippedAt(new \DateTime());
            }

            $entityManager->flush();
            $this->addFlash('success', 'Statut de la commande mis à jour avec succès.');
        } else {
            $this->addFlash('error', 'Statut invalide.');
        }

        return $this->redirectToRoute('app_admin_order_show', ['id' => $id]);
    }

    /**
     * Met à jour les informations de livraison (transporteur et numéro de suivi)
     */
    #[Route('/admin/orders/{id}/delivery', name: 'app_admin_order_delivery_update', methods: ['POST'])]
    public function updateDelivery(int $id, Request $request, OrderRepository $orderRepository, \Doctrine\ORM\EntityManagerInterface $entityManager): Response
    {
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        if (!$this->isCsrfTokenValid('order-delivery-' . $id, $request->request->get('_token'))) {
            $this->addFlash('error', 'Jeton de sécurité invalide.');
            return $this->redirectToRoute('app_admin_order_show', ['id' => $id]);
        }

        $order = $orderRepository->find($id);

        if (!$order) {
            $this->addFlash('error', 'Commande introuvable.');
            return $this->redirectToRoute('app_admin_orders');
        }

        $carrier = $request->request->get('carrier');
        $trackingNumber = $request->request->get('tracking_number');

        $order->setCarrier($carrier);
        $order->setTrackingNumber($trackingNumber);

        $entityManager->flush();

        $this->addFlash('success', 'Informations de livraison mises à jour.');

        return $this->redirectToRoute('app_admin_order_show', ['id' => $id]);
    }
}
