<?php

namespace App\Controller\Admin;

use App\Repository\OrderRepository;
use App\Repository\ProductRepository;
use App\Repository\UserRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class DashboardController extends AbstractController
{
    #[Route('/admin/dashboard', name: 'app_admin_dashboard')]
    public function index(
        ProductRepository $productRepository,
        UserRepository $userRepository,
        OrderRepository $orderRepository
    ): Response {
        $stats = [
            'total_products' => $productRepository->count([]),
            'total_users' => $userRepository->count([]),
            'total_orders' => $orderRepository->count([]),
            'low_stock_products' => count($productRepository->createQueryBuilder('p')
                ->where('p.stock < :threshold')
                ->setParameter('threshold', 10)
                ->getQuery()
                ->getResult()),
        ];

        $recentProducts = $productRepository->findBy([], ['id' => 'DESC'], 5);
        $recentUsers = $userRepository->findBy([], ['id' => 'DESC'], 5);
        $recentOrders = $orderRepository->findBy([], ['id' => 'DESC'], 5);

        return $this->render('admin/dashboard/index.html.twig', [
            'stats' => $stats,
            'recent_products' => $recentProducts,
            'recent_users' => $recentUsers,
            'recent_orders' => $recentOrders,
        ]);
    }
}
