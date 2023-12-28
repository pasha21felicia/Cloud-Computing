from config import db, ma
import datetime


class Article(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200))
    body = db.Column(db.Text())
    category = db.Column(db.String(60))
    image_url = db.Column(db.String(200))
    date = db.Column(db.DateTime, default=datetime.datetime.now)

    # user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)

    def __init__(self, title, body, category, image_url):
        self.title = title
        self.body = body
        self.category = category
        self.image_url = image_url
        # self.user_id = user_id

    # def get_author(self):
    #     return self.author;


class ArticlesSchema(ma.Schema):
    # author = ma.Nested(UsersSchema)

    class Meta:
        fields = ('id', 'title', 'body', 'date', 'category', 'image_url')
