<?php

namespace App\EventSubscriber;

use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpKernel\Event\ResponseEvent;
use Symfony\Component\HttpKernel\KernelEvents;

/**
 * Ajoute des en-têtes de sécurité HTTP pour améliorer la protection de l'application
 */
class SecurityHeadersSubscriber implements EventSubscriberInterface
{
    public static function getSubscribedEvents(): array
    {
        return [
            KernelEvents::RESPONSE => 'onKernelResponse',
        ];
    }

    public function onKernelResponse(ResponseEvent $event): void
    {
        $response = $event->getResponse();

        // X-Content-Type-Options : Empêche le navigateur de deviner le type MIME
        $response->headers->set('X-Content-Type-Options', 'nosniff');

        // X-Frame-Options : Protection contre les attaques de type clickjacking
        $response->headers->set('X-Frame-Options', 'DENY');

        // X-XSS-Protection : Active la protection XSS du navigateur (pour les anciens navigateurs)
        $response->headers->set('X-XSS-Protection', '1; mode=block');

        // Referrer-Policy : Contrôle la quantité d'informations du referrer envoyées
        $response->headers->set('Referrer-Policy', 'strict-origin-when-cross-origin');

        // Permissions-Policy : Limite les fonctionnalités du navigateur
        $response->headers->set(
            'Permissions-Policy',
            'geolocation=(), microphone=(), camera=()'
        );
    }
}
