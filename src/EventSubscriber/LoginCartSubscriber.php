<?php

namespace App\EventSubscriber;

use App\Entity\User;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\Security\Http\Event\InteractiveLoginEvent;
use Symfony\Component\Security\Http\SecurityEvents;

class LoginCartSubscriber implements EventSubscriberInterface
{
    private $requestStack;
    private $entityManager;

    public function __construct(RequestStack $requestStack, EntityManagerInterface $entityManager)
    {
        $this->requestStack = $requestStack;
        $this->entityManager = $entityManager;
    }

    public function onSecurityInteractiveLogin(InteractiveLoginEvent $event): void
    {
        $user = $event->getAuthenticationToken()->getUser();

        if (!$user instanceof User) {
            return;
        }

        $session = $this->requestStack->getSession();
        $sessionCart = $session->get('cart', []);
        $userCart = $user->getCart() ?? [];

        // Merge logic: Add user cart items to session cart
        foreach ($userCart as $id => $quantity) {
            if (isset($sessionCart[$id])) {
                $sessionCart[$id] += $quantity;
            } else {
                $sessionCart[$id] = $quantity;
            }
        }

        // Update session
        $session->set('cart', $sessionCart);

        // Update user
        $user->setCart($sessionCart);
        $this->entityManager->persist($user);
        $this->entityManager->flush();
    }

    public static function getSubscribedEvents(): array
    {
        return [
            SecurityEvents::INTERACTIVE_LOGIN => 'onSecurityInteractiveLogin',
        ];
    }
}
