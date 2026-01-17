<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Migration pour ajouter le champ isActive à la table user
 */
final class Version20260118000000 extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'Ajoute le champ isActive à la table user pour gérer l\'activation/désactivation des comptes';
    }

    public function up(Schema $schema): void
    {
        // Ajoute la colonne isActive avec valeur par défaut à true
        $this->addSql('ALTER TABLE user ADD is_active TINYINT(1) DEFAULT 1 NOT NULL');
    }

    public function down(Schema $schema): void
    {
        // Supprime la colonne isActive
        $this->addSql('ALTER TABLE user DROP is_active');
    }
}
