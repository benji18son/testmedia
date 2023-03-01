FROM php:7.4-apache

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    libicu-dev \
    libpng-dev \
    libzip-dev \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install -j$(nproc) \
    intl \
    pdo_mysql \
    gd \
    zip

# Download MediaWiki
RUN git clone --branch REL1_35 --depth 1 https://gerrit.wikimedia.org/r/mediawiki/core.git /var/www/html/

# Set up database configuration
COPY LocalSettings.php /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html/

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
