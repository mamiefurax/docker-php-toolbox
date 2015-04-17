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

RUN apt-get update -qq && \
	apt-get install --no-install-recommends -qy libmcrypt-dev zlib1g-dev sudo curl wget git ssh && \
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
	curl -o /phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && \
	curl -o /behat https://cloud.github.com/downloads/Behat/Behat/behat.phar && \
	curl -o /php-cs-fixer http://get.sensiolabs.org/php-cs-fixer.phar && \
	chmod +x /phpunit /composer /behat /php-cs-fixer /phpcs

WORKDIR /app
VOLUME ["/app"]
