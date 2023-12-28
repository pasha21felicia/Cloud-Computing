## Description

App News implemented in Flask and Vue.js, deployed on Docker and K8S

## Setup Local Version🧰

### Prerequisites 
- python3.11
- pipenv 
- pip3
- mysql
- dbeaver

0. Optional: In case you get errors installing the local environment because of MySQL
   Not fault-proven results but eventually worked out by doing one of these:
    ```
   # In the main console, install to have MySQL as standalon service
   brew install mysql
   pip3 install mysqlclient
   
   # In .zshrc or similar add these lines and see the pycharm python packages and try to install mysqlclient, flask-mysqldb from there...
   export PATH="/usr/local/opt/mysql-client/bin:$PATH"
   export LDFLAGS="-L/usr/local/opt/mysql-client/lib"
   export CPPFLAGS="-I/usr/local/opt/mysql-client/include"
   export PKG_CONFIG_PATH="/usr/local/opt/mysql-client/lib/pkgconfig"
    ```
   
1. Optional: Better use the local mysql for testing, it's faster for local development and testing
   
   ```
   # Start mysql service 
   brew services start mysql 
   
   # Enter inside mysql using the root user, by default it will have no password
   /opt/homebrew/bin/mysql -u root
   
   # Setup the root password
   ALTER USER 'root'@'localhost' IDENTIFIED BY 'rootpass';
   
   # Exit mysql CTL+X/C/Z and Login with the root password
   /opt/homebrew/bin/mysql -u root -p
   # Enter the root password
   
   # Create the databases for Users and for Articles
   CREATE DATABASE app_news;
   USE app_news;
   ```
   
2. Optional: Connect in DBeaver with to local mysql
   ```
   HOST = localhost
   user = root
   password = rootpass
   database = app_news
   port = 3306
   ```

3. In the root folder create a `.env` file typing in your terminal and add the necessary data:
    ```
   make .install
    ```
   
    ```
   # Normally the .env file should contain these data but in the code
   # For now they are hardcoded in ./backend/config.py line 23 and ./authentification/config.py line 23
   DB_USER=admin
   DB_PASSWORD=adminpass
   DB_HOST=192.168.0.4
   DB_NAME=app_news
   DB_ROOT_PASSWORD=rootpass
    ```

4. In the root folder Install the repo and flask/python dependencies typing in your terminal the following commands:
    ```
   make init
    ```
   
5. For Vue.js setup follow the Readme.md from folder ./frontend or easy steps for local tests:
    ```
    npm install
    npm install -g @vue/cli
    npm run serve
    ```
   
## Setup Docker Containers🧰
1. Create a `.env` file typing in your terminal and add the necessary data:
    ```
    make .install
    ```

2. Build the with docker-compose the 5 containers: for authentification, backend app, mysql db and for frontend app:
    ```
    docker-compose build
    ```
   
3. Start the containers:
    ```
   docker-compose up
    ```
4. For mysql container you may need to find the IPAddress of the container and expose it in the flask app:
    ```
   ## Check the running containers, extract <container id>
   docker ps  
   
   ## Find the IPAddress of the mysql container                       
   docker inspect <container id>     
    ```
5. Uncomment the line 24 in the ./backend/config.py and ./authentification/config.py from localhost to <IPAddress> of the mysql container:
    ```
   ## FROM this
   app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://<mydbuser>:<mydbpass>@localhost/<mydb>'
   
   ## TO this
   app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://<mydbuser>:<mydbpass>@<IPAddress>/<mydb>'
    ```