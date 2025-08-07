# Imagen base de PHP con FPM
FROM php:8.2-fpm

# Instalación de extensiones requeridas por Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    zip \
    unzip \
    curl \
    git \
    && docker-php-ext-install pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Configura el directorio de trabajo
WORKDIR /var/www/html

# Copia los archivos del backend (Laravel)
COPY Backend-main/ /var/www/html/

# Da permisos
RUN chown -R www-data:www-data /var/www/html

# Expone el puerto 80 (opcional, si usas Nginx puedes omitirlo)
EXPOSE 80
