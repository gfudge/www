FROM ubuntu:14.04

# Update packages
RUN apt-get update -y

# Install Python Setuptools and nginx
RUN apt-get install -y python-setuptools nginx git

# Fetch site source
RUN git close https://github.com/gfudge/www.git

# Configure nginx & restart
ADD config/nginx.conf /etc/nginx/nginx.conf
RUN service nginx restart

# Install pip
RUN easy_install pip

# Add and install Python modules
ADD requirements.txt /config/requirements.txt
RUN cd /config; pip install -r requirements.txt

# Bundle app source
ADD . /app

# Expose
EXPOSE  5000
EXPOSE  80

# Run
CMD ["python", "/app/application.py"]

