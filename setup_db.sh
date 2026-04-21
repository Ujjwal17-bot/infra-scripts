#!/bin/bash
set -e

DB_PASS="SecureAdmin123!"

echo "Updating packages..."
sudo apt update -y

echo "mysql-server mysql-server/root_password password $DB_PASS" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $DB_PASS" | sudo debconf-set-selections

echo "Installing MySQL..."
sudo DEBIAN_FRONTEND=noninteractive apt install mysql-server -y

echo "Configuring MySQL..."
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf

sudo systemctl restart mysql

echo "Creating DB and user..."
sudo mysql -u root -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS project_db;"
sudo mysql -u root -p"$DB_PASS" -e "CREATE USER IF NOT EXISTS 'web_user'@'%' IDENTIFIED BY 'app_password';"
sudo mysql -u root -p"$DB_PASS" -e "GRANT ALL PRIVILEGES ON project_db.* TO 'web_user'@'%';"
sudo mysql -u root -p"$DB_PASS" -e "FLUSH PRIVILEGES;"

echo "Database setup complete!"
