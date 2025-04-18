# Projet Docker-K8s : Architecture Web avec 3 conteneurs
Ce projet met en place une architecture web composée de trois conteneurs Docker interconnectés :

- MySQL pour la base de données

- Une application web développée avec Flask

- Nginx configuré en reverse proxy

L'objectif est de maîtriser à la fois le déploiement manuel avec des commandes Docker classiques et le déploiement déclaratif via Docker Compose. L’accent est mis sur la configuration réseau, la persistance des données, et la vérification de l’état des services (healthchecks).

Structure du projet
```bash
.
├── app/
│   ├── Dockerfile
│   ├── src/
│   └── conf/
├── mysql/
│   ├── Dockerfile
│   └── conf/init.sql
├── nginx/
│   ├── Dockerfile (optionnel)
│   └── conf/default.conf
├── compose.yaml
└── setup_manual.sh
```
## Fonctionnalités de l'application
- GET /health : renvoie un statut de santé de l’application (200 OK avec {"status": "healthy"})

- GET /data : interroge la base MySQL et affiche des données de test

## Partie 1 — Déploiement manuel avec setup_manual.sh
Le fichier setup_manual.sh contient toutes les commandes Docker nécessaires pour :

- réer les réseaux et volumes

- construire les images

- exécuter les conteneurs avec les bons paramètres

- connecter les services entre eux

## Lancement de l’architecture
bash
Copier
Modifier
./setup_manual.sh
## Nettoyage manuel
```bash
docker rm -f mysql_container app_container nginx_container
docker network rm db_network site_network
docker volume rm db_volume
```
## Accès à l’application
Une fois l'architecture lancée, l’application est accessible via Nginx à l’adresse suivante :

- http://localhost:5423/health

- http://localhost:5423/data

## Comportement attendu
- Tous les conteneurs doivent être démarrés et fonctionnels

- La route /health doit renvoyer : {"status": "healthy"}

- La route /data doit afficher les données présentes dans la base

- Le volume db_volume doit assurer la persistance des données MySQL, même après redémarrage du conteneur MySQL

## Technologies utilisées
- Docker

- Docker Compose

- Python (Flask)

- MySQL 8

- Nginx

### Remarques techniques
- L’image de l’application est basée sur python:<version>-alpine pour plus de légèreté

- Le Dockerfile de MySQL intègre un healthcheck

- Le healthcheck de l’application est défini dans compose.yaml via la route /health

- Nginx est configuré pour rediriger uniquement les routes /health et /data vers l'application
