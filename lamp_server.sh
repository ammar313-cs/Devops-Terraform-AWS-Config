#!/bin/bash

# Variables
app_name="My App"
username="username"
password="password"
db_name="my_database"

# Update System
sudo apt-get update
sudo apt-get upgrade

# Install Apache, MySQL, PHP (LAMP)
sudo apt-get install apache2 mysql-server php libapache2-mod-php php-mysql

# Enable mod_rewrite for .htaccess files
sudo a2enmod rewrite

# Start/Restart Apache for changes to take effect
sudo service apache2 restart

# Set up MySQL with password and create a database
sudo mysql -u root -p <<EOF
UPDATE mysql.user SET Password=PASSWORD('$password') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='temp';
FLUSH PRIVILEGES;
CREATE DATABASE $db_name;
CREATE USER '$username'@'localhost' IDENTIFIED BY '$password';
GRANT ALL PRIVILEGES ON $db_name.* TO '$username'@'localhost';
FLUSH PRIVILEGES;
EOF

# Set up Virtual Host
sudo mkdir /var/www/$app_name
sudo chown -R $username:$username /var/www/$app_name
sudo chmod -R 755 /var/www/$app_name

sudo bash -c "cat <<EOF > /etc/apache2/sites-available/$app_name.conf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/$app_name

    <Directory /var/www/$app_name>
        Options -Indexes +FollowSymLinks +MultiViews
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF"

sudo a2ensite $app_name.conf
sudo a2dissite 000-default.conf
sudo service apache2 reload

# Create index.php file
sudo bash -c "cat <<EOF > /var/www/$app_name/index.php
<?php
    phpinfo();
?>
EOF"

# Restart Apache
sudo service apache2 restart