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

DB_ENDPOINT = os.environ.get("DB_ENDPOINT")
DATABASE_NAME = os.environ.get("DATABASE_NAME")
DB_PASSWORD = os.environ.get("DB_PASSWORD")
DB_USER = os.environ.get("DB_USER")

load_dotenv()
time.sleep(10)
app_auth = Flask(__name__)
CORS(app_auth, resources={r"/*": {"origins": "http://localhost:8080"}})

# app_auth.config['SQLALCHEMY_DATABASE_URI'] = 'mysql_articles://root:root@localhost/app_users'         # mysql_articles local db
app_auth.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:rootpass@192.168.0.4:3306/app_news'       # docker-compose db
# app_auth.config['SQLALCHEMY_DATABASE_URI'] = 'mysql_articles://'+DB_USER+':'+DB_PASSWORD+'@'+DB_ENDPOINT+':3306/'+DATABASE_NAME # general db
app_auth.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app_auth.config['WTF_CSRF_ENABLED'] = False
app_auth.config['JWT_SECRET_KEY'] = '8bf194eca505a14a48a079410fdbd100'

db = SQLAlchemy(app_auth)
ma = Marshmallow(app_auth)
bcrypt = Bcrypt(app_auth)
jwt = JWTManager(app_auth)
