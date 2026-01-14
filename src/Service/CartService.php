<?php

namespace App\Service;

use App\Repository\ProductRepository;
use Symfony\Bundle\SecurityBundle\Security;
use Symfony\Component\HttpFoundation\RequestStack;
use Doctrine\ORM\EntityManagerInterface;
use App\Entity\User;

class CartService
{
    private $requestStack;
    private $productRepository;
    private $security;
    private $entityManager;

    public function __construct(
        RequestStack $requestStack, 
        ProductRepository $productRepository,
        Security $security,
        EntityManagerInterface $entityManager
    ) {
        $this->requestStack = $requestStack;
        $this->productRepository = $productRepository;
        $this->security = $security;
        $this->entityManager = $entityManager;
    }

    public function add(int $id): void
    {
        $session = $this->requestStack->getSession();
        $cart = $session->get('cart', []);

        if (!empty($cart[$id])) {
            $cart[$id]++;
        } else {
            $cart[$id] = 1;
        }

        $session->set('cart', $cart);
        $this->saveToUser($cart);
    }

    public function remove(int $id): void
    {
        $session = $this->requestStack->getSession();
        $cart = $session->get('cart', []);

        if (!empty($cart[$id])) {
            if ($cart[$id] > 1) {
                $cart[$id]--;
            } else {
                unset($cart[$id]);
            }
        }

        $session->set('cart', $cart);
        $this->saveToUser($cart);
    }

    public function getFullCart(): array
    {
        $session = $this->requestStack->getSession();
        $cart = $session->get('cart', []);

        $cartWithData = [];

        foreach ($cart as $id => $quantity) {
            $product = $this->productRepository->find($id);
            
            if ($product) {
                $cartWithData[] = [
                    'product' => $product,
                    'quantity' => $quantity
                ];
            }
        }

        return $cartWithData;
    }

    public function getTotal(): float
    {
        $fullCart = $this->getFullCart();
        $total = 0;

        foreach ($fullCart as $item) {
            $total += $item['product']->getPrice() * $item['quantity'];
        }

        return $total;
    }

    private function saveToUser(array $cart): void
    {
        $user = $this->security->getUser();

        if ($user instanceof User) {
            $user->setCart($cart);
            $this->entityManager->persist($user);
            $this->entityManager->flush();
        }
    }
}
