#!/bin/bash

sudo apt update -y
sudo apt install nginx -y
sudo apt install software-properties-common -y
sudo apt update -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt install php8.1-fpm php8.1-mysql php8.1-gd php8.1-cli php8.1-curl php8.1-mbstring php8.1-zip php8.1-opcache -y
sudo systemctl start nginx
sudo systemctl start php8.1-fpm