# wget https://cn.wordpress.org/wordpress-4.7.4-zh_CN.tar.gz
# tar zxf wordpress-4.7.4-zh_CN.tar.gz -C /app/wwwroot/

# sudo docker network create lnmp

# mysql 123456      ?? 
sudo docker run -itd \
--name lnmp_mysql \
--net lnmp \
-p 3308:3308 \
--mount src=mysql-vol,dst=/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
mysql --character-set-server=utf8

# db
sudo docker exec lnmp_mysql sh \
-c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e"create database wp"'

# php       ??
sudo docker run -itd \
--name lnmp_web \
--net lnmp \
-p 88:80 \
--mount type=bind,src=/app/wwwroot,dst=/var/www/html richarvey/nginx-php-fpm



http://192.168.11.3:88/wordpress

# curl 127.0.0.1:88
# iptables -I INPUT -s 0.0.0.0 -j 

