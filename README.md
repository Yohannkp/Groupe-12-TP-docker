# Docker-K8s - Projet Web 3 Conteneurs

Ce projet met en œuvre une architecture web complète composée de 3 conteneurs Docker :

- 🐬 MySQL (base de données)
- ⚙️ Application web (Flask + MySQL Connector)
- 🌐 Nginx (reverse proxy)

L’objectif est de maîtriser la mise en place **manuelle** et **déclarative (Docker Compose)** d’un système multi-conteneurs avec persistance, configuration réseau, et vérification d’état (healthcheck).

---

## 🗂 Arborescence du projet

./
├── app/
│   ├── Dockerfile
│   ├── src/
│   └── conf/   # (vide ou non)
├── mysql/
│   ├── Dockerfile
│   └── conf/init.sql
├── nginx/
│   ├── Dockerfile (facultatif)
│   └── conf/default.conf
├── compose.yaml
└── setup_manual.sh (ou .ps1)


---

## 🚀 Fonctionnalités de l'application

- `/health` : vérifie si l'application est en ligne (`200 OK + {"status": "healthy"}`)
- `/data` : récupère les données test stockées dans la base MySQL

---

## 🔧 Partie 1 — Lancement **manuel** (script)

Le script `setup_manual.sh` permet de créer et lancer l’architecture avec des commandes Docker classiques.

### ✅ Lancer :
```bash
./setup_manual.sh

```
###  🧹 Nettoyer :
docker rm -f mysql_container tpfinale-app-1 nginx_container
docker network rm tpfinale_db_network tpfinale_site_network
docker volume rm tpfinale_db_volume


###  🌐 Accès à l'application
L'application est accessible via le reverse proxy Nginx :

http://localhost:5423/health

http://localhost:5423/data


### ✅ Comportement attendu
Tous les conteneurs doivent être Up (healthy)

/health doit renvoyer un JSON : {"status": "healthy"}

/data doit renvoyer les messages test de la base

Le volume db_volume garantit la persistance des données MySQL

### 📌 Technologies utilisées
Docker 🐳

Docker Compose

Python (Flask)

MySQL 8

Nginx

### 📝 Remarques
Le Dockerfile de l'application utilise python:<version>-alpine

Le healthcheck MySQL est défini dans son Dockerfile

Le healthcheck de l'app est défini dans compose.yaml (test /health)

Nginx est configuré pour rediriger uniquement /health et /data vers le service app