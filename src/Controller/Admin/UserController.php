<?php

namespace App\Controller\Admin;

use App\Entity\User;
use App\Form\Admin\UserType;
use App\Repository\UserRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Attribute\Route;

final class UserController extends AbstractController
{
    /**
     * Liste tous les utilisateurs de la plateforme
     */
    #[Route('/admin/users', name: 'app_admin_users')]
    public function index(UserRepository $userRepository): Response
    {
        // Sécurité : Vérification explicite du rôle admin
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        $users = $userRepository->findAll();

        return $this->render('admin/user/index.html.twig', [
            'users' => $users,
        ]);
    }

    /**
     * Créer un nouvel utilisateur
     */
    #[Route('/admin/users/new', name: 'app_admin_user_new', priority: 2)]
    public function new(Request $request, UserPasswordHasherInterface $passwordHasher, \Doctrine\ORM\EntityManagerInterface $entityManager): Response
    {
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        $user = new User();
        $form = $this->createForm(UserType::class, $user);

        // On force l'ajout du champ mot de passe car c'est une création
        $form->add('plainPassword', \Symfony\Component\Form\Extension\Core\Type\PasswordType::class, [
            'mapped' => false,
            'label' => 'Mot de passe',
            'constraints' => [
                new \Symfony\Component\Validator\Constraints\NotBlank(message: 'Veuillez saisir un mot de passe'),
            ],
            'attr' => ['class' => 'form-control'],
        ]);

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $user->setPassword(
                $passwordHasher->hashPassword(
                    $user,
                    $form->get('plainPassword')->getData()
                )
            );
            $user->setIsActive(true);

            $entityManager->persist($user);
            $entityManager->flush();

            $this->addFlash('success', 'Utilisateur créé avec succès.');
            return $this->redirectToRoute('app_admin_users');
        }

        return $this->render('admin/user/new.html.twig', [
            'user' => $user,
            'form' => $form->createView(),
        ]);
    }

    /**
     * Affiche le profil détaillé d'un utilisateur
     */
    #[Route('/admin/users/{id}', name: 'app_admin_user_show')]
    public function show(int $id, UserRepository $userRepository, \Doctrine\ORM\EntityManagerInterface $entityManager): Response
    {
        // Sécurité : Vérification explicite du rôle admin
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        $user = $userRepository->find($id);

        if (!$user) {
            $this->addFlash('error', 'Utilisateur introuvable.');
            return $this->redirectToRoute('app_admin_users');
        }

        // Récupère les 5 dernières commandes de l'utilisateur pour l'activité récente
        $recentOrders = $entityManager->getRepository(\App\Entity\Order::class)->findBy(
            ['user' => $user],
            ['dateat' => 'DESC'],
            5
        );

        // Récupère toutes les commandes de l'utilisateur pour la section "Commandes associées"
        $userOrders = $entityManager->getRepository(\App\Entity\Order::class)->findBy(
            ['user' => $user],
            ['dateat' => 'DESC']
        );

        return $this->render('admin/user/show.html.twig', [
            'user' => $user,
            'recentOrders' => $recentOrders,
            'userOrders' => $userOrders,
        ]);
    }

    /**
     * Modifie les informations d'un utilisateur (rôles, email, profil)
     */
    #[Route('/admin/users/edit/{id}', name: 'app_admin_user_edit')]
    public function edit(int $id, \Symfony\Component\HttpFoundation\Request $request, UserRepository $userRepository, \Doctrine\ORM\EntityManagerInterface $entityManager): Response
    {
        // Sécurité : Vérification explicite du rôle admin
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        $user = $userRepository->find($id);

        if (!$user) {
            $this->addFlash('error', 'Utilisateur introuvable.');
            return $this->redirectToRoute('app_admin_users');
        }

        $form = $this->createForm(\App\Form\Admin\UserType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();
            $this->addFlash('success', 'Utilisateur mis à jour avec succès.');
            return $this->redirectToRoute('app_admin_users');
        }

        return $this->render('admin/user/edit.html.twig', [
            'user' => $user,
            'form' => $form->createView(),
        ]);
    }

    /**
     * Supprime un compte utilisateur
     * Sécurisé par CSRF et empêche la suppression des administrateurs
     */
    #[Route('/admin/users/delete/{id}', name: 'app_admin_user_delete', methods: ['POST'])]
    public function delete(int $id, \Symfony\Component\HttpFoundation\Request $request, UserRepository $userRepository, \Doctrine\ORM\EntityManagerInterface $entityManager): Response
    {
        // Sécurité : Vérification explicite du rôle admin
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        $user = $userRepository->find($id);

        if (!$user) {
            $this->addFlash('error', 'Utilisateur introuvable.');
            return $this->redirectToRoute('app_admin_users');
        }

        if ($this->isCsrfTokenValid('delete' . $user->getId(), $request->request->get('_token'))) {
            // Sécurité : Empêcher la suppression d'un administrateur
            if (in_array('ROLE_ADMIN', $user->getRoles())) {
                $this->addFlash('error', 'Les comptes administrateurs ne peuvent pas être supprimés.');
                return $this->redirectToRoute('app_admin_users');
            }
            // Sécurité supplémentaire : Empêcher la suppression de soi-même
            if ($user === $this->getUser()) {
                $this->addFlash('error', 'Vous ne pouvez pas supprimer votre propre compte.');
                return $this->redirectToRoute('app_admin_users');
            }

            $entityManager->remove($user);
            $entityManager->flush();
            $this->addFlash('success', 'Utilisateur supprimé avec succès.');
        }

        return $this->redirectToRoute('app_admin_users');
    }

    /**
     * Déclenche une réinitialisation de mot de passe pour un utilisateur
     */
    #[Route('/admin/users/reset-password/{id}', name: 'app_admin_user_reset_password', methods: ['POST'])]
    public function resetPassword(int $id, \Symfony\Component\HttpFoundation\Request $request, UserRepository $userRepository, \Doctrine\ORM\EntityManagerInterface $entityManager): Response
    {
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        $user = $userRepository->find($id);

        if (!$user) {
            $this->addFlash('error', 'Utilisateur introuvable.');
            return $this->redirectToRoute('app_admin_users');
        }

        if ($this->isCsrfTokenValid('reset-password' . $user->getId(), $request->request->get('_token'))) {
            // Générer un token de réinitialisation
            $token = bin2hex(random_bytes(32));
            $user->setResetToken($token);
            $user->setResetTokenExpiresAt(new \DateTimeImmutable('+1 hour'));
            $entityManager->flush();

            $resetUrl = $this->generateUrl('app_reset_password', ['token' => $token], \Symfony\Component\Routing\Generator\UrlGeneratorInterface::ABSOLUTE_URL);

            $this->addFlash('success', 'Un lien de réinitialisation a été généré pour ' . $user->getEmail());
            $this->addFlash('info', 'Lien (développement) : ' . $resetUrl);
        }

        return $this->redirectToRoute('app_admin_user_show', ['id' => $user->getId()]);
    }

    /**
     * Active ou désactive un compte utilisateur
     */
    #[Route('/admin/users/toggle-active/{id}', name: 'app_admin_user_toggle_active', methods: ['POST'])]
    public function toggleActive(int $id, \Symfony\Component\HttpFoundation\Request $request, UserRepository $userRepository, \Doctrine\ORM\EntityManagerInterface $entityManager): Response
    {
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        $user = $userRepository->find($id);

        if (!$user) {
            $this->addFlash('error', 'Utilisateur introuvable.');
            return $this->redirectToRoute('app_admin_users');
        }

        if ($this->isCsrfTokenValid('toggle-active' . $user->getId(), $request->request->get('_token'))) {
            // Sécurité : Empêcher de désactiver son propre compte
            if ($user === $this->getUser()) {
                $this->addFlash('error', 'Vous ne pouvez pas désactiver votre propre compte.');
                return $this->redirectToRoute('app_admin_user_show', ['id' => $user->getId()]);
            }

            $user->setIsActive(!$user->isActive());
            $entityManager->flush();

            $status = $user->isActive() ? 'activé' : 'désactivé';
            $this->addFlash('success', 'Le compte de ' . $user->getEmail() . ' a été ' . $status . ' avec succès.');
        }

        return $this->redirectToRoute('app_admin_user_show', ['id' => $user->getId()]);
    }
}
