<?php

namespace App\Controller\Admin;

use App\Repository\NewsletterRepository;
use App\Repository\OrderRepository;
use App\Repository\ProductRepository;
use App\Repository\UserRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

/**
 * Contrôleur du tableau de bord de l'administration
 * 
 * Centralise les statistiques globales et les activités récentes de la boutique.
 */
final class DashboardController extends AbstractController
{
    /**
     * Affiche la vue d'ensemble du tableau de bord
     * 
     * @param ProductRepository $productRepository Le repository pour les statistiques produits
     * @param UserRepository $userRepository Le repository pour les statistiques utilisateurs
     * @param OrderRepository $orderRepository Le repository pour les statistiques commandes
     * @param NewsletterRepository $newsletterRepository Le repository pour les statistiques newsletter
     * @return Response Une instance de Response vers la vue du dashboard
     */
    #[Route('/admin/dashboard', name: 'app_admin_dashboard')]
    public function index(
        ProductRepository $productRepository,
        UserRepository $userRepository,
        OrderRepository $orderRepository,
        \App\Repository\TestimonialRepository $testimonialRepository,
        NewsletterRepository $newsletterRepository
    ): Response {
        // Sécurité : Vérification explicite du rôle admin
        $this->denyAccessUnlessGranted('ROLE_ADMIN');
        $stats = [
            'total_products' => $productRepository->count([]),
            'total_users' => $userRepository->count([]),
            'total_orders' => $orderRepository->count([]),
            'total_testimonials' => $testimonialRepository->count([]),
            'total_newsletter' => $newsletterRepository->countActiveSubscribers(),
            'low_stock_products' => count($productRepository->createQueryBuilder('p')
                ->where('p.stock < :threshold')
                ->setParameter('threshold', 10)
                ->getQuery()
                ->getResult()),
        ];

        $recentProducts = $productRepository->findBy([], ['id' => 'DESC'], 5);
        $recentUsers = $userRepository->findBy([], ['id' => 'DESC'], 5);
        $recentOrders = $orderRepository->findBy([], ['id' => 'DESC'], 5);
        $recentTestimonials = $testimonialRepository->findBy([], ['id' => 'DESC'], 5);
        $recentNewsletter = $newsletterRepository->findRecentSubscribers(5);

        return $this->render('admin/dashboard/index.html.twig', [
            'stats' => $stats,
            'recent_products' => $recentProducts,
            'recent_users' => $recentUsers,
            'recent_orders' => $recentOrders,
            'recent_testimonials' => $recentTestimonials,
            'recent_newsletter' => $recentNewsletter,
        ]);
    }
}
