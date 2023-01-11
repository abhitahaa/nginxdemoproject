#!/bin/bash


nginx_status=$(systemctl is-active nginx)
php_status=$(systemctl is-active php8.1-fpm)

if [ $nginx_status == "active" ] && [ $php_status == "active" ]
then
  sudo chmod -R 777 /var/www/html
  cd /var/www/html/
  git clone https://github.com/tahashinegp/ecommerce.git
  cd /etc/nginx/sites-available/
  touch ecommerce.com
  cat <<EOF > ecommerce.com
server {
    listen 80;
    index index.php index.html;
    server_name _;
    error_log  /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
    root /var/www/html/ecommerce;
    location /  {
        try_files $uri $uri/ /index.php?$query_string;
        index  index.php index.html index.htm;
        autoindex on;
        }
    location ~ \.php$ {
        try_files $uri $uri /index.php$is_args$args;
        autoindex on;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        #fastcgi_pass unix:/run/php/php5-fpm.sock;
        fastcgi_pass unix:/run/php/php5.4-fpm.sock;
        #fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
}
EOF
 
  sudo ln -s /etc/nginx/sites-available/ecommerce.com /etc/nginx/sites-enabled/
  rm -rf /etc/nginx/sites-available/default
  rm -rf /etc/nginx/sites-enabled/default
  sudo nginx -t
  sudo systemctl reload nginx

  echo "Nginx and PHP are running"
  echo "all process are running now"
 
  
  exit 0
else
  echo "Nginx and PHP are not running"
  exit 1
fi