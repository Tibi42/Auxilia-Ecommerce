<?php

namespace App\Controller;

use App\Repository\OrderRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class OrderController extends AbstractController
{
    #[Route('/profile/orders', name: 'app_orders')]
    public function index(OrderRepository $orderRepository): Response
    {
        $user = $this->getUser();
        
        if (!$user) {
            return $this->redirectToRoute('app_login');
        }

        $orders = $orderRepository->findBy(
            ['user' => $user],
            ['dateat' => 'DESC']
        );

        return $this->render('order/index.html.twig', [
            'orders' => $orders,
        ]);
    }

    #[Route('/profile/orders/{id}', name: 'app_order_show')]
    public function show(int $id, OrderRepository $orderRepository): Response
    {
        $user = $this->getUser();
        
        if (!$user) {
            return $this->redirectToRoute('app_login');
        }

        $order = $orderRepository->find($id);

        if (!$order || $order->getUser() !== $user) {
            $this->addFlash('error', 'Commande introuvable.');
            return $this->redirectToRoute('app_orders');
        }

        return $this->render('order/show.html.twig', [
            'order' => $order,
        ]);
    }
}


