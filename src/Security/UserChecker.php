<?php

namespace App\Security;

use App\Entity\User;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Core\Exception\CustomUserMessageAccountStatusException;
use Symfony\Component\Security\Core\User\UserCheckerInterface;
use Symfony\Component\Security\Core\User\UserInterface;

/**
 * Vérifie l'état du compte utilisateur lors de l'authentification
 */
class UserChecker implements UserCheckerInterface
{
    /**
     * Vérifie l'état de l'utilisateur avant l'authentification
     * 
     * @param UserInterface $user L'utilisateur à vérifier
     * @throws CustomUserMessageAccountStatusException Si le compte est désactivé
     */
    public function checkPreAuth(UserInterface $user): void
    {
        if (!$user instanceof User) {
            return;
        }

        if (!$user->isActive()) {
            throw new CustomUserMessageAccountStatusException(
                'Votre compte a été désactivé. Veuillez contacter l\'administrateur.'
            );
        }
    }

    /**
     * Vérifie l'état de l'utilisateur après l'authentification
     * 
     * @param UserInterface $user L'utilisateur à vérifier
     * @param TokenInterface|null $token Le token d'authentification
     */
    public function checkPostAuth(UserInterface $user, ?TokenInterface $token = null): void
    {
        // Pas de vérification supplémentaire après l'authentification
    }
}
