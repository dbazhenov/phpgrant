#!/usr/bin/env bash

source /home/vagrant/.phpbrew/bashrc

sudo cp /vagrant/vhosts/*.conf /etc/apache2/sites-available/

for file in /vagrant/vhosts/*.conf
do
	sudo a2ensite $(basename "$file" .conf)
done

sudo service apache2 restart

phpbrew fpm start