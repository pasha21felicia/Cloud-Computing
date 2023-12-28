import os
import time

from dotenv import load_dotenv
from flask import Flask
from flask_bcrypt import Bcrypt
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy

load_dotenv()
DB_ENDPOINT = os.environ.get("DB_ENDPOINT")
DATABASE_NAME = os.environ.get("DATABASE_NAME")
DB_PASSWORD = os.environ.get("DB_PASSWORD")
DB_USER = os.environ.get("DB_USER")


time.sleep(10)
app = Flask(__name__)
CORS(app, supports_credentials=True, expose_headers='Authorization', origins=['http://localhost:8080'])

# app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:root@localhost/app_news'          # mysql_articles local db
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://admin:adminpass@192.168.0.4:3306/app_news'       # docker-compose db
# app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://'+DB_USER+':'+DB_PASSWORD+'@'+DB_ENDPOINT+':3306/'+DATABASE_NAME   # general db
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['WTF_CSRF_ENABLED'] = False
app.config['JWT_SECRET_KEY'] = '8bf194eca505a14a48a079410fdbd100'

db = SQLAlchemy(app)
ma = Marshmallow(app)
bcrypt = Bcrypt(app)
jwt = JWTManager(app)
