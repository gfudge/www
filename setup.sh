#!/bin/bash

# Set up the system
sudo apt-get install python-dev build-essential python-pip nginx
sudo apt-get update
sudo pip install virtualenv uwsgi

# Setup filesystem
cd ~
mkdir -p /var/log/uwsgi
mkdir -p /etc/uwsgi/apps-available
mkdir -p /etc/uwsgi/apps-enabled
mkdir -p /var/www/run

# Copy site files
cd ~/www
cp -R blog/ /var/www/blog
sudo chown -R nginx:nginx /var/www

# Copy config files
cd ~/www
cp ./config/uwsgi/uwsgi.conf /etc/init/uwsgi.conf
cp ./config/uwsgi/apps-available/* /etc/uwsgi/apps-available/blog.ini
cp ./config/nginx/default.conf /etc/nginx/conf.f/default.conf

# Link app
sudo ln -s /etc/uwsgi/apps-available/blog.ini /etc/uwsgi/apps-enabled/blog.ini

# Setup a virtualenv
cd ~/www
virtualenv venv
. venv/bin/activate
sudo pip install Flask
deactivate

# Fire it up
sudo service nginx start
