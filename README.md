# PHP tools for easier docker based development

This is a `simple` docker image for running various PHP tools from the CLI / IDE.

## Usage

Go to the root directory of your app and choose what to do

### PHPUnit

``` docker run -it --rm -w /app -v $(pwd):/app docker-php-toolbox:latest /phpunit ```

### Composer

``` docker run -it --rm -w /app -v $(pwd):/app docker-php-toolbox:latest /composer ```

### Behat

``` docker run -it --rm -w /app -v $(pwd):/app docker-php-toolbox:latest / behat ```

## Additional notes

### Xdebug

XDebug is automatically running so don't worry about it !

### scripts
One handy trick is to create a few run commands or alias for even easier use

i.e. ~/bin/phpunit

``` 
#!/bin/bash
docker run \
	-it \
	--rm \
	-v $(pwd):/app \
	-w /app \
	docker-php-toolbox:latest /phpunit $*
```
for the other tools, you could replace ```phpunit``` with ```composer``` or ```behat```

### version information

In order to allow easier switching of the various tools between PHP versions. We've tagged the PHP version as the image tag.
Thus using ```docker-php-toolbox:latest``` will use the latest PHP stable, but ```docker-php-toolbox:5.4``` will use 5.4 ;)
