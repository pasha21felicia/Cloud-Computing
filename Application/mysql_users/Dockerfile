# Use an official MySQL runtime as a parent image
FROM mysql:latest

# Set the MYSQL_ROOT_PASSWORD environment variable
ENV MYSQL_ROOT_PASSWORD=rootpass
ENV MYSQL_DATABASE=app_users
ENV MYSQL_USER=admin
ENV MYSQL_PASSWORD=adminpass

# Expose the default MySQL port
EXPOSE 3306

# Copy the custom configuration file to set the MySQL data directory
COPY my.cnf /etc/mysql/conf.d/my.cnf

# Define the command to run your application
CMD ["mysqld"]
