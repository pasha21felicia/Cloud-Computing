#!/bin/bash

# Access the environment variables
db_host="${DB_HOST%:3306}"
db_user="$DB_USER"
db_password="$DB_PASSWORD"
db_name="$DB_NAME"

# Import data using the environment variables
mysql -h $db_host -u "$db_user" -p"$db_password" "$db_name" < /Users/parascoviadigori/Documents/Infrastructure/scripts/backup.sql

# Import the data into the new RDS database
#mysql --verbose -h dbappnews.czcj54fag4dh.us-east-1.rds.amazonaws.com -u root -p"app_news" app_news < /Users/parascoviadigori/Documents/Infrastructure/scripts/backup.sql
