setenv $APPNAME="myapp"
sudo apt-get install python-dev build-essential python-pip nginx
sudo apt-get update
sudo useradd -c 'uwsgi user,,,' -g nginx -d /nonexistent -s /bin/false uwsgi
sudo pip install virtualenv
sudo virtualenv --system-site-packages /srv/webapps/$APPNAME/env
source /srv/webapps/$APPNAME/env/bin/activate
sudo pip install flask
deactivate
sudo mkdir -p /etc/webapps/$APPNAME
cd /etc/webapps/$APPNAME
sudo mkdir $APPNAME
sudo mkdir $APPNAME/static
sudo touch $APPNAME/__init__.py

