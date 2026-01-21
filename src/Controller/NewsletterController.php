<?php

namespace App\Controller;

use App\Entity\Newsletter;
use App\Repository\NewsletterRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class NewsletterController extends AbstractController
{
    /**
     * Inscription à la newsletter (API endpoint)
     */
    #[Route('/newsletter/subscribe', name: 'app_newsletter_subscribe', methods: ['POST'])]
    public function subscribe(
        Request $request,
        EntityManagerInterface $entityManager,
        NewsletterRepository $newsletterRepository,
        ValidatorInterface $validator
    ): JsonResponse {
        $email = $request->request->get('email');

        if (!$email) {
            return new JsonResponse([
                'success' => false,
                'message' => 'L\'adresse email est obligatoire.'
            ], Response::HTTP_BAD_REQUEST);
        }

        // Vérifier si l'email est déjà inscrit
        if ($newsletterRepository->isEmailSubscribed($email)) {
            return new JsonResponse([
                'success' => false,
                'message' => 'Cette adresse email est déjà inscrite à la newsletter.'
            ], Response::HTTP_CONFLICT);
        }

        // Créer le nouvel abonné
        $newsletter = new Newsletter();
        $newsletter->setEmail($email);

        // Valider l'entité
        $errors = $validator->validate($newsletter);
        if (count($errors) > 0) {
            $errorMessages = [];
            foreach ($errors as $error) {
                $errorMessages[] = $error->getMessage();
            }
            return new JsonResponse([
                'success' => false,
                'message' => implode(' ', $errorMessages)
            ], Response::HTTP_BAD_REQUEST);
        }

        $entityManager->persist($newsletter);
        $entityManager->flush();

        return new JsonResponse([
            'success' => true,
            'message' => 'Merci ! Vous êtes maintenant inscrit à notre newsletter.'
        ]);
    }

    /**
     * Page d'administration de la newsletter
     */
    #[Route('/admin/newsletter', name: 'app_admin_newsletter')]
    public function adminIndex(NewsletterRepository $newsletterRepository): Response
    {
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        $subscribers = $newsletterRepository->findBy([], ['subscribedAt' => 'DESC']);
        $activeCount = $newsletterRepository->countActiveSubscribers();

        return $this->render('admin/newsletter/index.html.twig', [
            'subscribers' => $subscribers,
            'activeCount' => $activeCount,
            'totalCount' => count($subscribers),
        ]);
    }

    /**
     * Activer/Désactiver un abonné
     */
    #[Route('/admin/newsletter/{id}/toggle', name: 'app_admin_newsletter_toggle', methods: ['POST'])]
    public function toggleSubscriber(
        Newsletter $newsletter,
        EntityManagerInterface $entityManager
    ): Response {
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        $newsletter->setIsActive(!$newsletter->isActive());
        $entityManager->flush();

        $this->addFlash('success', 'Statut de l\'abonné mis à jour.');
        return $this->redirectToRoute('app_admin_newsletter');
    }

    /**
     * Supprimer un abonné
     */
    #[Route('/admin/newsletter/{id}/delete', name: 'app_admin_newsletter_delete', methods: ['POST'])]
    public function deleteSubscriber(
        Newsletter $newsletter,
        EntityManagerInterface $entityManager,
        Request $request
    ): Response {
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        if ($this->isCsrfTokenValid('delete' . $newsletter->getId(), $request->request->get('_token'))) {
            $entityManager->remove($newsletter);
            $entityManager->flush();
            $this->addFlash('success', 'Abonné supprimé avec succès.');
        }

        return $this->redirectToRoute('app_admin_newsletter');
    }
}
