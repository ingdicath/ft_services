#!/bin/sh
mysql_install_db --user=grogu --ldata=/var/lib/mysql

echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" >> /init.sql
echo "SET PASSWORD FOR '$MYSQL_USER'@'localhost'=PASSWORD('${MYSQL_USERPASS}');" >> /init.sql
echo "GRANT ALL ON *.* TO '$MYSQL_USER'@'127.0.0.1' IDENTIFIED BY '$MYSQL_USERPASS' WITH GRANT OPTION;" >> /init.sql
echo "GRANT ALL ON *.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_USERPASS' WITH GRANT OPTION;" >> /init.sql
echo "GRANT ALL ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USERPASS' WITH GRANT OPTION;" >> /init.sql
echo "FLUSH PRIVILEGES;" >> /init.sql

mysqld --console --init_file=/init.sql