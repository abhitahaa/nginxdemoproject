#!/bin/bash

# Update package list and upgrade installed packages

# sudo apt-get update
# sudo apt-get upgrade -y


yum check-update
sudo yum update -y

sudo yum install nginx -y



# Install Nginx

sudo apt-get install nginx -y

# Install PHP and required modules
sudo apt-get install php8.1-fpm php8.1-cli php8.1-common php8.1-mbstring php8.1-gd php8.1-intl php8.1-xml php8.1-mysql php8.1-zip -y

# Start Nginx and PHP-FPM services
sudo systemctl start nginx
sudo systemctl start php8.1-fpm

# Enable Nginx and PHP-FPM services to start on boot
# sudo systemctl enable nginx
# sudo systemctl enable php8.1-fpm

# Check if both the service are running or not

# nginx_status=$(systemctl is-active nginx)
# php_status=$(systemctl is-active php8.1-fpm)

# if [ $nginx_status == "active" ] && [ $php_status == "active" ]
# then
#   sudo chmod -R 777 /var/www/html
#   cd /var/www/html/
#   git clone https://github.com/tahashinegp/ecommerce.git
#   cd /etc/nginx/sites-available/
#   touch ecommerce.com
#   cat <<EOF > ecommerce.com
# server {
#     listen 80;
#     index index.php index.html;
#     server_name _;
#     error_log  /var/log/nginx/error.log;
#     access_log /var/log/nginx/access.log;
#     root /var/www/html/ecommerce;
#     location /  {
#         try_files $uri $uri/ /index.php?$query_string;
#         index  index.php index.html index.htm;
#         autoindex on;
#         }
#     location ~ \.php$ {
#         try_files $uri $uri /index.php$is_args$args;
#         autoindex on;
#         fastcgi_split_path_info ^(.+\.php)(/.+)$;
#         fastcgi_pass unix:/run/php/php8.1-fpm.sock;
#         #fastcgi_pass 127.0.0.1:9000;
#         fastcgi_index index.php;
#         include fastcgi_params;
#         fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
#         fastcgi_param PATH_INFO $fastcgi_path_info;
#     }
# }
# EOF
 
#   sudo ln -s /etc/nginx/sites-available/ecommerce.com /etc/nginx/sites-enabled/
#   rm -rf /etc/nginx/sites-available/default
#   rm -rf /etc/nginx/sites-enabled/default
#   sudo nginx -t
#   sudo systemctl reload nginx

#   echo "Nginx and PHP are running"
#   echo "all process are running now"
 
  
#   exit 0
# else
#   echo "Nginx and PHP are not running"
#   exit 1
# fi





sudo apt update
sudo apt install --no-install-recommends php8.1
sudo apt-get install -y php8.1-cli php8.1-common php8.1-mysql php8.1-zip php8.1-gd php8.1-mbstring php8.1-curl php8.1-xml php8.1-bcmath
