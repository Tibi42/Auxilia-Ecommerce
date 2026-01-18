<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\ChangePasswordFormType;
use App\Form\ProfileFormType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Attribute\Route;

/**
 * Contrôleur gérant le compte utilisateur côté client
 */
class ProfileController extends AbstractController
{
    /**
     * Affiche et gère le profil utilisateur et le changement de mot de passe
     */
    #[Route('/profile', name: 'app_profile')]
    public function index(
        Request $request,
        EntityManagerInterface $entityManager,
        UserPasswordHasherInterface $passwordHasher
    ): Response {
        /** @var User $user */
        $user = $this->getUser();

        // Redirige si non connecté
        if (!$user) {
            return $this->redirectToRoute('app_login');
        }

        // --- Gestion du Formulaire de Profil ---
        $profileForm = $this->createForm(ProfileFormType::class, $user);
        $profileForm->handleRequest($request);

        if ($profileForm->isSubmitted() && $profileForm->isValid()) {
            $entityManager->flush();
            $this->addFlash('success', 'Vos informations ont été mises à jour avec succès !');
            return $this->redirectToRoute('app_profile');
        }

        // --- Gestion du Formulaire de Changement de Mot de Passe ---
        $passwordForm = $this->createForm(ChangePasswordFormType::class);
        $passwordForm->handleRequest($request);

        if ($passwordForm->isSubmitted() && $passwordForm->isValid()) {
            $currentPassword = $passwordForm->get('currentPassword')->getData();
            $newPassword = $passwordForm->get('newPassword')->getData();

            // Vérification du mot de passe actuel avant modification
            if (!$passwordHasher->isPasswordValid($user, $currentPassword)) {
                $this->addFlash('error', 'Le mot de passe actuel est incorrect.');
            } else {
                // Hachage et mise à jour du nouveau mot de passe
                $hashedPassword = $passwordHasher->hashPassword($user, $newPassword);
                $user->setPassword($hashedPassword);
                $entityManager->flush();

                $this->addFlash('success', 'Votre mot de passe a été modifié avec succès !');
                return $this->redirectToRoute('app_profile');
            }
        }

        return $this->render('profile/index.html.twig', [
            'profileForm' => $profileForm,
            'passwordForm' => $passwordForm,
            'user' => $user,
        ]);
    }

    /**
     * Supprime le compte utilisateur
     */
    /**
     * Supprime le compte utilisateur
     */
    #[Route('/profile/delete', name: 'app_profile_delete', methods: ['POST'])]
    public function delete(Request $request, EntityManagerInterface $entityManager, UserPasswordHasherInterface $passwordHasher): Response
    {
        $user = $this->getUser();
        if (!$user) {
            return $this->redirectToRoute('app_login');
        }

        if ($this->isCsrfTokenValid('delete_account', $request->request->get('_token'))) {
            $password = $request->request->get('password');

            // Vérification du mot de passe
            if (!$password || !$passwordHasher->isPasswordValid($user, $password)) {
                $this->addFlash('error', 'Mot de passe incorrect. Impossible de supprimer le compte.');
                return $this->redirectToRoute('app_profile');
            }

            $entityManager->remove($user);
            $entityManager->flush();

            $request->getSession()->invalidate();
            $this->container->get('security.token_storage')->setToken(null);

            $this->addFlash('success', 'Votre compte a été supprimé avec succès.');
            return $this->redirectToRoute('app_home');
        }

        $this->addFlash('error', 'Token CSRF invalide.');
        return $this->redirectToRoute('app_profile');
    }
}
