###
#
# A simple image for running various PHP tools:
# phpunit executable via /phpunit
# composer executable via /composer
#
# The app should be mounted into /app to work
#
###
FROM php:5.4-cli
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
	echo "date.timezone = $TZ" > /usr/local/etc/php/conf.d/timezone.ini && \
	echo "phar.readonly = Off" > /usr/local/etc/php/conf.d/phar.ini

RUN curl -O -L https://phar.phpunit.de/phpunit.phar && \	
	curl -O -L https://getcomposer.org/composer.phar && \
	curl -O -L https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && \
	curl -O -L https://github.com/Behat/Behat/releases/download/v3.0.15/behat.phar && \
	curl -O -L http://get.sensiolabs.org/php-cs-fixer.phar && \
	chmod +x /phpunit.phar /composer.phar /behat.phar /php-cs-fixer.phar /phpcs.phar

RUN mkdir /Symfony2-coding-standard && git clone git://github.com/escapestudios/Symfony2-coding-standard.git /Symfony2-coding-standard
RUN /phpcs.phar --config-set installed_paths /Symfony2-coding-standard

RUN apt-get clean 
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app
VOLUME ["/app"]
