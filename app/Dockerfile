# Utiliser l'avant-dernière version alpine de python (ex : 3.12.2-alpine3.19 au lieu de latest)
FROM python:3.12.2-alpine3.19

# Installer les dépendances système
RUN apk add --no-cache gcc musl-dev libffi-dev mariadb-connector-c-dev

# Installer les dépendances Python
RUN pip install flask mysql-connector-python

# Copier le code source dans le conteneur
WORKDIR /app
COPY src/ /app

# Exposer le port interne sur lequel l'app écoute
EXPOSE 4743

# Commande de lancement de l'application
CMD ["python", "main.py"]
