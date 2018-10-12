#!/bin/bash

sudo bash /etc/nginx/ssl.sh
sudo systemctl start mariadb.service
sudo systemctl start redis
sudo systemctl start nginx
sudo systemctl start php-fpm
# https://blog.bgbgbg.net/archives/4213
sudo chmod 701 /home/docker
