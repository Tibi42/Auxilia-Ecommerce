<?php

namespace App\Repository;

use App\Entity\Order;
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
     * 
     * @param string|null $status Le statut à filtrer, null pour toutes les commandes
     * @return Order[] Liste des commandes
     */
    public function findAllByStatus(?string $status = null): array
    {
        $qb = $this->createQueryBuilder('o')
            ->orderBy('o.id', 'DESC');

        if ($status !== null && $status !== '') {
            $qb->andWhere('o.status = :status')
               ->setParameter('status', $status);
        }

        return $qb->getQuery()->getResult();
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
