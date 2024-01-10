from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from flask_cors import CORS
from flask_bcrypt import Bcrypt
from flask_jwt_extended import JWTManager
import time
import os
from dotenv import load_dotenv
load_dotenv()

DB_URL = os.environ.get("DB_URL")
DB_PASSWORD = os.environ.get("DB_PASSWORD")
DB_USER = os.environ.get("DB_USER")
DB_DATABASE = os.environ.get("DB_DATABASE")

ORIGINS_URL = os.environ.get("ORIGINS_URL")
JWT_SECRET_KEY = os.environ.get("JWT_SECRET_KEY")


load_dotenv()
# time.sleep(10)
app_auth = Flask(__name__)
CORS(app_auth, resources={r"/*": {'origins': ORIGINS_URL}})

# app_auth.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:root@localhost/app_users'         # mysql_articles local db
# app_auth.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://admin:adminpass@192.168.0.4:3306/app_news'       # docker-compose db
app_auth.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://'+DB_USER+':'+DB_PASSWORD+'@'+DB_URL+'/'+DB_DATABASE # general db
app_auth.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app_auth.config['WTF_CSRF_ENABLED'] = False
app_auth.config['JWT_SECRET_KEY'] = JWT_SECRET_KEY

db = SQLAlchemy(app_auth)
ma = Marshmallow(app_auth)
bcrypt = Bcrypt(app_auth)
jwt = JWTManager(app_auth)
