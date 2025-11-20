# Use a base image with PHP and necessary extensions
FROM php:8.2-cli

# Install dependencies (Composer, git, and required PHP extensions)
RUN apt-get update && apt-get install -y git zip unzip \
    && docker-php-ext-install pcntl posix

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set the working directory
WORKDIR /app

# Copy the application code into the container
COPY . /app

# Install PHP dependencies using Composer
RUN composer install

# Expose the port (Workerman often uses 8383)
EXPOSE 8383

# Define the command to start the Workerman server in the foreground
CMD ["php", "start.php", "start"]
