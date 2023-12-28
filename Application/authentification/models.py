from config import db, ma


class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    image_file = db.Column(db.String(200), nullable=False,
                           default='https://cdn-icons-png.flaticon.com/512/327/327525.png?w=996&t=st=1679595871~exp=1679596471~hmac=fcfe9be5455cb34e8f64d9bcb54203068be2e04a0c32051e6b30acad6b7d9e05')
    password = db.Column(db.String(60), nullable=False)

    def __init__(self, username, email, password):
        self.username = username
        self.email = email
        self.password = password


class UsersSchema(ma.Schema):
    class Meta:
        fields = ('id', 'username', 'email', 'image_file', 'password')
