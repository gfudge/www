#!/bin/bash

# Set up the system
sudo apt-get install python-dev build-essential python-pip nginx
sudo apt-get update
sudo pip install virtualenv uwsgi 
sudo apt-get install uwsgi-plugin-python

# Setup filesystem
cd ~
sudo mkdir -p /var/log/uwsgi
sudo mkdir -p /etc/uwsgi/apps-available
sudo mkdir -p /etc/uwsgi/apps-enabled
sudo mkdir -p /var/www/run

# Copy site files
cd ~/www
sudo cp -R blog/ /var/www/
sudo chown -R www-data:www-data /var/www
sudo chown -R www-data:www-data /var/log/uwsgi

# Copy config files
cd ~/www
sudo cp ./config/uwsgi/uwsgi.conf /etc/init/uwsgi.conf
sudo cp ./config/uwsgi/apps-available/blog.ini /etc/uwsgi/apps-available/blog.ini
sudo cp ./config/nginx/default.conf /etc/nginx/conf.d/default.conf

# Link app
sudo ln -s /etc/uwsgi/apps-available/blog.ini /etc/uwsgi/apps-enabled/blog.ini

# Setup a virtualenv
cd ~/www
virtualenv venv
. venv/bin/activate
sudo pip install Flask
#deactivate

# Fire it up
sudo service uwsgi restart
sudo service nginx restart
