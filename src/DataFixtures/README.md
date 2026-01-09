# Fixtures - Données de test

Ce dossier contient les fixtures pour peupler la base de données avec des données de test.

## Fixtures disponibles

### UserFixtures
Crée des utilisateurs de test :
- **Admin** : `admin@auxilia-ecommerce.com` / `admin123` (ROLE_ADMIN)
- **Utilisateurs** : 
  - `user1@example.com` / `user123`
  - `user2@example.com` / `user123`
  - `marie.dupont@example.com` / `password123`
  - `jean.martin@example.com` / `password123`

### ProductFixtures
Crée :
- **6 catégories** : Électronique, Vêtements, Maison & Décoration, Sport & Fitness, Livres, Jouets
- **28 produits** répartis dans les différentes catégories avec :
  - Descriptions détaillées
  - Prix variés
  - Stocks réalistes

### AppFixtures
Fixture principale qui charge les autres fixtures dans l'ordre correct.

## Utilisation

Pour charger les fixtures dans la base de données :

```bash
php bin/console doctrine:fixtures:load
```

⚠️ **Attention** : Cette commande va supprimer toutes les données existantes et les remplacer par les fixtures.

Pour charger uniquement une fixture spécifique :

```bash
php bin/console doctrine:fixtures:load --group=UserFixtures
```

## Structure des données

### Catégories
- Électronique (5 produits)
- Vêtements (5 produits)
- Maison & Décoration (5 produits)
- Sport & Fitness (5 produits)
- Livres (3 produits)
- Jouets (3 produits)

### Produits
Chaque produit contient :
- Un nom
- Une description détaillée
- Un prix (en euros)
- Un stock (quantité disponible)
- Une catégorie associée

