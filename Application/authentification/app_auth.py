from datetime import timedelta

from flask import jsonify
from flask_jwt_extended import (
    jwt_required, create_access_token, current_user, unset_jwt_cookies,
)
from flask_jwt_extended.exceptions import JWTExtendedException

from config import db, app_auth, bcrypt, jwt
from forms import RegistrationForm, LoginForm
from models import User, UsersSchema
import json
from dotenv import load_dotenv

load_dotenv()

# define the table schemas
user_schema = UsersSchema()
users_schema = UsersSchema(many=True)

def populate_db(user_data):
    username = user_data['username']
    email = user_data['email']
    password = user_data['password']
    hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')

    users_instance = User(username=username, email=email, password=hashed_password)
    db.session.add(users_instance)
    db.session.commit()


# create all the database tables
with app_auth.app_context():
    db.create_all()

    if db.session.query(User).count() == 0:
        with open('users.json') as json_file:
            users = json.load(json_file)
            for user_data in users:
                populate_db(user_data)

        print('Database populated successfully.')


# User Authentication
@app_auth.route('/auth/register', methods=['POST'])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        username = form.username.data
        email = form.email.data
        password = form.password.data
        hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')

        user = User(username=username, email=email, password=hashed_password)
        db.session.add(user)
        db.session.commit()
        return jsonify({'message': 'User registered successfully'})
    return jsonify({'errors': form.errors}), 400


# User Login
@app_auth.route('/auth/login', methods=['POST'])
def login():
    form = LoginForm()

    if form.validate_on_submit():
        email = form.email.data
        password = form.password.data

        user = User.query.filter_by(email=email).first()
        if user and bcrypt.check_password_hash(user.password, form.password.data):
            access_token = create_access_token(identity=email, expires_delta=timedelta(hours=24),
                                               additional_claims={"email": email})
            result = user_schema.dump(user)
            response = jsonify({"user": result, "access_token": access_token, "message": "Successful Login"})

            return response, 201
        if not user or not user.password == password:
            return jsonify({'message': 'Invalid email or password'}), 401


# User logout
@app_auth.route('/auth/logout', methods=['POST'])
@jwt_required()
def logout():
    try:
        # Clear the access token cookie
        response = jsonify({'message': 'Successfully logged out'})
        unset_jwt_cookies(response)
        return response
    except JWTExtendedException as e:
        return jsonify({'message': str(e)}), 401


# Get all users
@app_auth.route('/auth/users/get', methods=['GET'])
def get_users():
    all_users = User.query.all()
    result = users_schema.dump(all_users)
    return jsonify(result), 201


@jwt.user_identity_loader
def user_identity_lookup(email):
    user = User.query.filter_by(email=email).first()
    print(user)
    return user.id


@jwt.user_lookup_loader
def user_lookup_callback(_jwt_header, jwt_data):
    identity = jwt_data["sub"]
    print(identity)
    return User.query.filter_by(id=identity).one_or_none()


@app_auth.route("/auth/me", methods=["GET"])
@jwt_required()
def protected():
    # We can now access our sqlalchemy User object via `current_user`.
    user = user_schema.dump(current_user)
    return user


if __name__ == "__main__":
    app_auth.run(host='0.0.0.0', port=8001, debug=True)
