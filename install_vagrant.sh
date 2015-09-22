#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update

sudo apt-get upgrade

sudo locale-gen ru_RU.UTF-8

sudo apt-get install -y nano htop git software-properties-common python-software-properties unzip

sudo apt-get install -y apache2 apache2-utils

sudo a2enmod proxy_fcgi rewrite

sudo service apache2 restart

sudo adduser vagrant www-data

sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db

## MongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
sudo add-apt-repository 'deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse'

## MariaDB
sudo add-apt-repository 'deb http://mirror.timeweb.ru/mariadb/repo/10.1/ubuntu trusty main'
sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password root'

## Nginx
wget 'http://nginx.org/keys/nginx_signing.key'
sudo apt-key add nginx_signing.key
rm nginx_signing.key
sudo add-apt-repository 'deb http://nginx.org/packages/ubuntu/ trusty nginx'
sudo add-apt-repository 'deb-src http://nginx.org/packages/ubuntu/ trusty nginx'

sudo apt-get update

sudo apt-get install -y mongodb-org
sudo apt-get install -y mariadb-server mariadb-client libmariadbclient-dev libmariadbd-dev
sudo apt-get install -y nginx-full

echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;" | mysql -uroot -proot
echo "FLUSH PRIVILEGES;" | mysql -uroot -proot

sudo apt-get install optipng jpegoptim pngcrush pngquant gifsicle libjpeg-turbo-progs

sudo apt-get build-dep php5
sudo apt-get install -y php5 php5-dev php-pear autoconf automake curl build-essential libxslt1-dev re2c libxml2 libxml2-dev php5-cli bison libbz2-dev libreadline-dev
sudo apt-get install -y libfreetype6 libfreetype6-dev libpng12-0 libpng12-dev libjpeg-dev libjpeg8-dev libjpeg8  libgd-dev libgd3 libxpm4 libltdl7 libltdl-dev
sudo apt-get install -y libssl-dev openssl
sudo apt-get install -y gettext libgettextpo-dev libgettextpo0
sudo apt-get install -y libicu-dev
sudo apt-get install -y libmhash-dev libmhash2
sudo apt-get install -y libmcrypt-dev libmcrypt4
sudo apt-get install -y imagemagick libmagickcore5 libmagickwand5 libmagickwand-dev libcurl3-openssl-dev
ln -s /usr/include/freetype2 /usr/include/freetype2/freetype

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
echo "export PATH=~/.composer/vendor/bin:$PATH" >> ~/.bashrc

composer global require phpunit/phpunit
composer global require phpunit/dbunit

curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
chmod +x phpbrew
sudo mv phpbrew /usr/bin/phpbrew
phpbrew init

echo "export PHPBREW_SET_PROMPT=1" >> ~/.bashrc
echo "source /home/vagrant/.phpbrew/bashrc" >> ~/.bashrc
source /home/vagrant/.phpbrew/bashrc

phpbrew lookup-prefix ubuntu

phpbrew install 5.6.13 +default +fpm +curl +intl +mysql +gettext +opcache
phpbrew install 5.3.29 +default +fpm +curl +intl +mysql +gettext +zip

phpbrew clean 5.6.13
phpbrew clean 5.3.29

phpbrew switch php-5.6.13

phpbrew ext install xdebug stable
phpbrew ext install opcache stable
phpbrew ext install imagick stable
phpbrew ext install apcu latest
phpbrew ext install mongo stable
phpbrew ext install gd -- --with-freetype-dir=/usr/include/freetype2 --with-gd=shared,/usr --with-png-dir=/usr/local --with-jpeg-dir=/usr/local
