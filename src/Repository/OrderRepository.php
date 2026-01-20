<?php

namespace App\Repository;

use App\Entity\Order;
use App\Entity\User;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * Dépôt de l'entité Order, gérant les requêtes personnalisées liées aux commandes
 * @extends ServiceEntityRepository<Order>
 */
class OrderRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Order::class);
    }

    /**
     * Récupère toutes les commandes filtrées par statut si fourni
     * Optimisé avec fetch join pour éviter les requêtes N+1 sur User et OrderItems
     * 
     * @param string|null $status Le statut à filtrer, null pour toutes les commandes
     * @return Order[] Liste des commandes
     */
    public function findAllByStatus(?string $status = null): array
    {
        $qb = $this->createQueryBuilder('o')
            ->leftJoin('o.user', 'u')
            ->addSelect('u')
            ->leftJoin('o.orderItems', 'oi')
            ->addSelect('oi')
            ->orderBy('o.id', 'DESC');

        if ($status !== null && $status !== '') {
            $qb->andWhere('o.status = :status')
               ->setParameter('status', $status);
        }

        return $qb->getQuery()->getResult();
    }

    /**
     * Récupère les commandes d'un utilisateur avec les items (optimisé)
     * 
     * @param User $user L'utilisateur
     * @return Order[] Liste des commandes de l'utilisateur
     */
    public function findByUserWithItems(User $user): array
    {
        return $this->createQueryBuilder('o')
            ->leftJoin('o.orderItems', 'oi')
            ->addSelect('oi')
            ->leftJoin('oi.product', 'p')
            ->addSelect('p')
            ->andWhere('o.user = :user')
            ->setParameter('user', $user)
            ->orderBy('o.dateat', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Récupère une commande avec tous ses détails (optimisé)
     * 
     * @param int $id L'identifiant de la commande
     * @return Order|null La commande ou null
     */
    public function findOneWithDetails(int $id): ?Order
    {
        return $this->createQueryBuilder('o')
            ->leftJoin('o.user', 'u')
            ->addSelect('u')
            ->leftJoin('o.orderItems', 'oi')
            ->addSelect('oi')
            ->leftJoin('oi.product', 'p')
            ->addSelect('p')
            ->andWhere('o.id = :id')
            ->setParameter('id', $id)
            ->getQuery()
            ->getOneOrNullResult();
    }

    /**
     * Récupère tous les statuts distincts
     * 
     * @return string[] Liste des statuts uniques
     */
    public function findDistinctStatuses(): array
    {
        $qb = $this->createQueryBuilder('o')
            ->select('DISTINCT o.status')
            ->orderBy('o.status', 'ASC');

        $results = $qb->getQuery()->getResult();
        
        // Extraire les valeurs de statuts du tableau associatif
        return array_map(function($row) {
            return $row['status'];
        }, $results);
    }

    //    /**
    //     * @return Order[] Returns an array of Order objects
    //     */
    //    public function findByExampleField($value): array
    //    {
    //        return $this->createQueryBuilder('o')
    //            ->andWhere('o.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->orderBy('o.id', 'ASC')
    //            ->setMaxResults(10)
    //            ->getQuery()
    //            ->getResult()
    //        ;
    //    }

    //    public function findOneBySomeField($value): ?Order
    //    {
    //        return $this->createQueryBuilder('o')
    //            ->andWhere('o.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }
}
