import os, sys, json
import flask
from flask import request, Response

# New application
application = flask.Flask(__name__)

# Default route
@application.route('/')
def index():
    return 'Index Page'

@application.route('/about')
def about():
    return 'About'

@application.route('/projects')
def projects():
    return 'Projects'

if __name__ == '__main__':
	application.run()

