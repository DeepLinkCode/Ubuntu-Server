#!/bin/bash

echo "x============================x"
echo "Provisioning virtual machine..."
sudo apt-get update && sudo apt-get -y upgrade

echo "Installing required tools !"
echo "----------------------------------------------------"
sleep 1

sudo apt-get -y install git

sudo apt-get -y install net-tools

sudo apt-get -y intall dos2unix

echo "Installing nginx Server !"
echo "----------------------------------------------------"
sleep 1

wget https://raw.githubusercontent.com/angristan/nginx-autoinstall/master/nginx-autoinstall.sh

chmod +x nginx-autoinstall.sh

HEADLESS=y \
NGINX_VER=MAINLINE \
HEADERMOD=y \
./nginx-autoinstall.sh

echo "Adding PHP ondre Repo !"
echo "----------------------------------------------------"
sleep 1

sudo add-apt-repository ppa:ondrej/php

sudo apt-get update

echo "Adding PHP ondre Repo: Done !"
echo "----------------------------------------------------"
sleep 1

echo "Installing PHP 7.2: and required extensions  !"
echo "----------------------------------------------------"
sleep 1

sudo apt-get -y install php7.2-cli php7.2-fpm php7.2-curl php7.2-gd php7.2-mysql php7.2-mbstring zip unzip

sudo apt-get -y install php7.2-xml php7.2-zip php7.2-bz2 php7.2-bcmath php7.2-soap php7.2-msgpack

echo "Installing mongoDB !"
echo "----------------------------------------------------"
sleep 1

sudo apt-get -y install gnupg

wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

sudo apt-get update

sudo apt-get -y install mongodb-org=4.4.8 mongodb-org-server=4.4.8 mongodb-org-shell=4.4.8 mongodb-org-mongos=4.4.8 mongodb-org-tools=4.4.8

sudo apt -y install php7.2-mongodb

echo "Installing mysql-server !"
echo "----------------------------------------------------"
sleep 1

sudo apt install -y mysql-server

echo "Installing redis-server !"
echo "----------------------------------------------------"
sleep 1

sudo apt install -y redis-server

sudo apt install -y php7.2-redis

sed -e 's/^supervised no/supervised systemd/' \
    -e 's/^# *bind 127\.0\.0\.1 ::1/bind 127.0.0.1 ::1/' \
    /etc/redis/redis.conf >/etc/redis/redis.conf.new
# $(date +%y%b%d-%H%M%S) == "18Aug13-125913"
mv /etc/redis/redis.conf /etc/redis/redis.conf.$(date +%y%b%d-%H%M%S)
mv /etc/redis/redis.conf.new /etc/redis/redis.conf
sudo systemctl start redis-server
sleep 1
if [[ "$( echo 'ping' | /usr/bin/redis-cli )" == "PONG" ]] ; then
    echo "ping worked"
else
    echo "ping FAILED"
fi

echo "Restarting all services !"
echo "----------------------------------------------------"
sudo systemctl restart nginx 
sudo systemctl status nginx
echo "Nginx restart : Done !"
echo "----------------------------------------------------"
sleep 1
sudo systemctl restart php7.2-fpm 
sudo systemctl status php7.2-fpm 
echo "php7.1-fpm restart : Done !"
echo "----------------------------------------------------"
sleep 1
sudo systemctl restart mongod
sudo systemctl status mongod
echo "mongo restart Done !"
echo "----------------------------------------------------"
sleep 1
sudo systemctl restart mysql 
sudo systemctl status mysql
echo "mysql restart : Done !"
echo "----------------------------------------------------"
sleep 1

sudo systemctl restart redis-server
sudo systemctl status redis-server
echo "redis restart : Done !"
echo "----------------------------------------------------"
sleep 1

echo "systemctl enabling all services for boot !"
echo "----------------------------------------------------"

sudo systemctl enable /lib/systemd/system/redis-server.service
sudo systemctl enable nginx
sudo systemctl enable mysql
sudo systemctl enable mongod
sudo systemctl enable php7.2-fpm

sleep 1

echo "Provisioning Done ...!"