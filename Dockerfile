# ============================================================
#  Dockerfile — Apache + PHP 7.4
#  Compatible Mac Intel (x86_64) et Mac Apple Silicon (arm64)
# ============================================================

FROM php:7.4-apache

# ── Mise à jour du système et dépendances nécessaires aux extensions PHP ──
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# ── Configuration de l'extension GD (images) ──
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg

# ── Installation des extensions PHP ──
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    mysqli \
    gd \
    zip \
    mbstring \
    xml \
    opcache

# ── Activation de mod_rewrite Apache (nécessaire pour .htaccess) ──
RUN a2enmod rewrite

# ── Configuration Apache : autoriser .htaccess dans /var/www/html ──
RUN sed -i 's/AllowOverride None/AllowOverride All/g' \
    /etc/apache2/apache2.conf

# ── Répertoire de travail ──
WORKDIR /var/www/html

# ── Exposer le port HTTP ──
EXPOSE 80
