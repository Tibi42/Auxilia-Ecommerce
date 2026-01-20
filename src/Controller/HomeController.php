<?php

namespace App\Controller;

use App\Repository\ProductRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

/**
 * Contrôleur gérant la page d'accueil du site
 */
final class HomeController extends AbstractController
{
    /**
     * Affiche la page d'accueil avec les derniers produits ajoutés
     */
    #[Route('/', name: 'app_home')]
    public function index(ProductRepository $productRepository, \App\Repository\TestimonialRepository $testimonialRepository): Response
    {
        // Récupère les produits mis en avant pour la section "Produits à la une" (avec cache)
        $featuredProducts = $productRepository->findFeaturedProducts(8);

        // Récupère les témoignages approuvés depuis la base de données
        $dbTestimonials = $testimonialRepository->findApproved(3);

        $testimonials = [];
        foreach ($dbTestimonials as $t) {
            $testimonials[] = [
                'author' => $t->getName(),
                'rating' => $t->getRating(),
                'content' => $t->getContent(),
                'avatar' => 'https://i.pravatar.cc/150?u=' . md5($t->getEmail()), // Avatar dynamique basé sur l'email
                'date' => 'Le ' . $t->getCreatedAt()->format('d/m/Y')
            ];
        }

        // Si aucun témoignage en base, on garde les mocks pour ne pas laisser la section vide au début
        if (empty($testimonials)) {
            $testimonials = [
                [
                    'author' => 'Marie Laurent',
                    'rating' => 5,
                    'content' => 'Une expérience d\'achat incroyable ! Les produits sont de très haute qualité et la livraison a été ultra rapide.',
                    'avatar' => 'https://i.pravatar.cc/150?u=marie',
                    'date' => 'Compte de démonstration'
                ],
                [
                    'author' => 'Jean-Pierre Martin',
                    'rating' => 4,
                    'content' => 'Très satisfait de mon nouvel ordinateur. Le service client a été de bon conseil.',
                    'avatar' => 'https://i.pravatar.cc/150?u=jeanpierre',
                    'date' => 'Compte de démonstration'
                ],
                [
                    'author' => 'Sophie Durand',
                    'rating' => 5,
                    'content' => 'Le meilleur site e-commerce que j\'ai utilisé récemment. L\'interface est fluide.',
                    'avatar' => 'https://i.pravatar.cc/150?u=sophie',
                    'date' => 'Compte de démonstration'
                ]
            ];
        }

        return $this->render('home/index.html.twig', [
            'featuredProducts' => $featuredProducts,
            'testimonials' => $testimonials,
        ]);
    }
}
