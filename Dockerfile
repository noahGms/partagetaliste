# Utilisation de l'image Ruby officielle
FROM ruby:3.1.2-slim

# Installation des dépendances nécessaires
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Configuration du répertoire de travail
WORKDIR /app

# Copie des fichiers de gestion des dépendances
COPY Gemfile Gemfile.lock ./

# Installation des gems
RUN bundle install

# Installation des gems nécessaires pour le frontend
RUN npm install -g yarn
RUN yarn install

# Compilation de Tailwind CSS
RUN rails tailwindcss:build

# Création de la base de données et exécution des migrations
RUN rails db:create db:migrate

# Copie du reste de l'application
COPY . .

# Exposition du port
EXPOSE 3000

# Commande par défaut pour démarrer l'application
CMD ["rails", "server", "-b", "0.0.0.0"]
