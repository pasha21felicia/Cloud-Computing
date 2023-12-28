from flask import jsonify, request
from flask_jwt_extended import (
    jwt_required, create_access_token, current_user, unset_jwt_cookies,
)
from config import db, app, jwt
from models import Article, ArticlesSchema
import json
from dotenv import load_dotenv

load_dotenv()

# define the table schemas
article_schema = ArticlesSchema()
articles_schema = ArticlesSchema(many=True)


def populate_db(article_data):
    title = article_data['title']
    body = article_data['body']
    category = article_data['category']
    image_url = article_data['image_url']

    articles_instance = Article(title=title, body=body, category=category, image_url=image_url)
    db.session.add(articles_instance)
    db.session.commit()


# Create all the database tables
with app.app_context():
    db.create_all()

    if db.session.query(Article).count() == 0:
        with open('articles.json') as json_file:
            articles = json.load(json_file)
            for article_data in articles:
                populate_db(article_data)

        print('Database populated successfully.')


@app.route('/articles/get', methods=['GET'])
def get_articles():
    all_articles = Article.query.all()
    result = articles_schema.dump(all_articles)
    return jsonify(result), 201


@app.route('/articles/<category>/', methods=['GET'])
def get_articles_by_category(category):
    category_articles = Article.query.filter_by(category=category).all()
    result = articles_schema.dump(category_articles)
    return jsonify(result), 201


@app.route('/articles/get/<id>/', methods=['GET'])
def post_details(id):
    article = Article.query.get(id)
    result = article_schema.dump(article)
    return jsonify(result), 201


@app.route('/articles/add', methods=['POST'])
@jwt_required()
def add_articles():
    title = request.json['title']
    body = request.json['body']
    category = request.json['category']
    image_url = request.json['image_url']

    article = Article(title, body, category, image_url)
    db.session.add(article)
    db.session.commit()
    return article_schema.jsonify(article), 201


@app.route('/articles/update/<int:id>/', methods=['PUT'])
@jwt_required()
def update_article(id):
    article = Article.query.get(id)
    if not article:
        return jsonify({"message": "Article not found"}), 404

    try:
        article.title = request.json['title']
        article.body = request.json['body']
        article.category = request.json['category']
        article.image_url = request.json['image_url']
        db.session.commit()
        return article_schema.jsonify(article)
    except KeyError as e:
        return jsonify({"message": f"Missing required field: {str(e)}"}), 400


@app.route('/articles/delete/<id>/', methods=['DELETE'])
@jwt_required()
def delete_article(id):
    article = Article.query.get(id)
    db.session.delete(article)
    db.session.commit()
    return article_schema.jsonify(article)


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8000, debug=True)
