<?php

namespace App\Controller;

use App\Repository\ProductRepository;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class ProductController extends AbstractController
{
    #[Route('/product', name: 'app_product')]
    public function index(ProductRepository $productRepository, PaginatorInterface $paginator, Request $request): Response
    {
        $limit = $request->query->getInt('limit', 9);
        $sort = $request->query->get('sort', 'p.id');
        $direction = $request->query->get('direction', 'asc');

        // Allow only specific sort fields to prevent SQL injection or errors
        $allowedSorts = ['p.price', 'p.name', 'p.id'];
        if (!in_array($sort, $allowedSorts)) {
            $sort = 'p.id';
        }

        $queryBuilder = $productRepository->createQueryBuilder('p')
            ->orderBy($sort, $direction);

        $pagination = $paginator->paginate(
            $queryBuilder,
            $request->query->getInt('page', 1),
            $limit
        );
        
        return $this->render('product/index.html.twig', [
            'pagination' => $pagination,
            'currentLimit' => $limit,
            'currentSort' => $sort,
            'currentDirection' => $direction
        ]);
    }
}
