###
#
# A simple image for running various PHP tools:
# phpunit executable via /phpunit
# composer executable via /composer
#
# The app should be mounted into /app to work
#
###
FROM php:cli
MAINTAINER mamiefurax <mamiefurax@gmail.com>

ENV TZ "Europe/Paris"

RUN apt-get update && \
	apt-get install --no-install-recommends -qy git libmcrypt-dev zlib1g-dev && \
	apt-get autoremove -yq --purge && \
	rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* && \
	docker-php-ext-install mcrypt && \
	docker-php-ext-install zip && \
	docker-php-ext-install mbstring && \
	pecl install xdebug && \
	echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini && \
	echo "date.timezone = $TZ" > /usr/local/etc/php/conf.d/timezone.ini

RUN curl -o /phpunit https://phar.phpunit.de/phpunit.phar && \
	curl -o /composer https://getcomposer.org/composer.phar && \
	curl -o /behat https://github.com/downloads/Behat/Behat/behat.phar && \
	chmod +x /phpunit /composer /behat

WORKDIR /app
VOLUME ["/app"]
