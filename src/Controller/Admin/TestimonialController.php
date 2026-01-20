<?php

namespace App\Controller\Admin;

use App\Repository\TestimonialRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/admin/testimonials')]
final class TestimonialController extends AbstractController
{
    #[Route('', name: 'app_admin_testimonials')]
    public function index(TestimonialRepository $testimonialRepository): Response
    {
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        return $this->render('admin/testimonial/index.html.twig', [
            'testimonials' => $testimonialRepository->findBy([], ['createdAt' => 'DESC']),
        ]);
    }

    #[Route('/approve/{id}', name: 'app_admin_testimonial_approve', methods: ['POST'])]
    public function approve(int $id, Request $request, TestimonialRepository $testimonialRepository, EntityManagerInterface $entityManager): Response
    {
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        if (!$this->isCsrfTokenValid('approve' . $id, $request->request->get('_token'))) {
            $this->addFlash('error', 'Token invalide.');
            return $this->redirectToRoute('app_admin_testimonials');
        }

        $testimonial = $testimonialRepository->find($id);
        if ($testimonial) {
            $testimonial->setIsApproved(true);
            $entityManager->flush();
            $this->addFlash('success', 'Témoignage approuvé !');
        }

        return $this->redirectToRoute('app_admin_testimonials');
    }

    #[Route('/reject/{id}', name: 'app_admin_testimonial_reject', methods: ['POST'])]
    public function reject(int $id, Request $request, TestimonialRepository $testimonialRepository, EntityManagerInterface $entityManager): Response
    {
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        if (!$this->isCsrfTokenValid('reject' . $id, $request->request->get('_token'))) {
            $this->addFlash('error', 'Token invalide.');
            return $this->redirectToRoute('app_admin_testimonials');
        }

        $testimonial = $testimonialRepository->find($id);
        if ($testimonial) {
            $testimonial->setIsApproved(false);
            $entityManager->flush();
            $this->addFlash('success', 'Témoignage retiré de l\'affichage.');
        }

        return $this->redirectToRoute('app_admin_testimonials');
    }

    #[Route('/delete/{id}', name: 'app_admin_testimonial_delete', methods: ['POST'])]
    public function delete(int $id, Request $request, TestimonialRepository $testimonialRepository, EntityManagerInterface $entityManager): Response
    {
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        if (!$this->isCsrfTokenValid('delete' . $id, $request->request->get('_token'))) {
            $this->addFlash('error', 'Token invalide.');
            return $this->redirectToRoute('app_admin_testimonials');
        }

        $testimonial = $testimonialRepository->find($id);
        if ($testimonial) {
            $entityManager->remove($testimonial);
            $entityManager->flush();
            $this->addFlash('success', 'Témoignage supprimé.');
        }

        return $this->redirectToRoute('app_admin_testimonials');
    }
}
