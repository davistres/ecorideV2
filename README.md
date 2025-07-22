Pour garantir que chaque développeur travaille dans un environnement identique, fiable et facile à installer, le projet est entièrement "conteneurisé" avec Docker. Cela évite d'avoir à installer PHP, MySQL ou Nginx directement sur sa machine.

Choix principal : Docker Compose\*\*
Justification : Nous utilisons Docker Compose car il permet de définir et de lancer toute l'architecture de l'application (serveur web, serveur PHP, bases de données) avec une seule commande. C'est la garantie que l'environnement de développement sera strictement le même pour tout le monde et très proche de l'environnement de production.

Prérequis
Avant de commencer, assurez-vous d'avoir installé :

1. Git : Pour récupérer le code source depuis le dépôt.
2. Docker Desktop : L'outil qui va nous permettre de créer et gérer nos conteneurs.
3. Visual Studio Code : Notre éditeur de code recommandé pour ses extensions utiles et son terminal intégré.

Étapes d'installation

1. Cloner le projet
   Récupérez les fichiers du projet sur votre ordinateur.
   bash
   git clone <votre-url-git>
   cd ecoride-v2

2. Configurer les variables d'environnement
   Le fichier `.env` contient les informations sensibles et la configuration de l'environnement (connexions aux bases de données, etc.). Il n'est jamais partagé sur Git.
   bash

# Copiez le fichier d'exemple pour créer votre propre configuration locale

cp .env.example .env

Justification\*\* : Cette étape est cruciale pour la sécurité et la portabilité. Chacun peut avoir des configurations différentes (par exemple, des ports différents) sans affecter les autres.

3. Lancer l'environnement Docker
   Cette commande unique va construire et démarrer tous les services décrits dans le fichier `docker-compose.yml`.
   bash
   docker-compose up -d

Justification : L'option `-d` (detached) lance les conteneurs en arrière-plan, ce qui libère votre terminal pour d'autres commandes.

4. Installer les dépendances du projet
   Les dépendances PHP (Laravel) et JavaScript (Vite) doivent être installées à l'intérieur du conteneur `app`.
   bash

# Installer les dépendances PHP avec Composer

docker-compose exec app composer install

Installer les dépendances JS avec NPM
docker-compose exec app npm install

Justification : En exécutant ces commandes via `docker-compose exec`, on s'assure que les dépendances sont installées dans l'environnement contrôlé de Docker, et non sur notre machine locale.

5. Générer la clé d'application Larave
   bash
   docker-compose exec app php artisan key:generate

Justification : C'est une étape de sécurité indispensable pour que Laravel puisse chiffrer les sessions et autres données sensibles.

Votre environnement de développement est maintenant prêt !

L'application est accessible à l'adresse : `http://localhost`
La base de données MySQL est gérable via phpMyAdmin à : `http://localhost:8080`
