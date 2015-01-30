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
sudo add-apt-repository 'deb http://mirror.timeweb.ru/mariadb/repo/10.1/ubuntu trusty main'
sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password root'

sudo apt-get update

sudo apt-get install -y mariadb-server mariadb-client libmariadbclient-dev libmariadbd-dev

echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;" | mysql -uroot -proot
echo "FLUSH PRIVILEGES;" | mysql -uroot -proot

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

curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
chmod +x phpbrew
sudo mv phpbrew /usr/bin/phpbrew
phpbrew init

echo "export PHPBREW_SET_PROMPT=1" >> ~/.bashrc
echo "source /home/vagrant/.phpbrew/bashrc" >> ~/.bashrc
source /home/vagrant/.phpbrew/bashrc

phpbrew lookup-prefix ubuntu

sudo cp /vagrant/phpswitch /usr/bin/phpswitch
sudo chmod +x /usr/bin/phpswitch

phpbrew install 5.6.4 +default +fpm +curl +intl +mcrypt +mysql +fileinfo +zip +filter +gettext +opcache +zip
phpbrew install 5.3.29 +default +fpm +curl +intl +mcrypt +mysql +fileinfo +zip +filter +gettext +zip

phpbrew clean 5.6.4
phpbrew clean 5.3.29

phpbrew switch php-5.6.4

phpbrew ext install xdebug stable
phpbrew ext install opcache stable
phpbrew ext install imagick stable
phpbrew ext install APCu stable
phpbrew ext install gd -- --with-freetype-dir=/usr/include/freetype2 --with-gd=shared,/usr --with-png-dir=/usr/local --with-jpeg-dir=/usr/local
