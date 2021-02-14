mysql_install_db --user=grogu --ldata=/var/lib/mysql

echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" >> /init.sql
echo "SET PASSWORD FOR '$DB_USER'@'localhost'=PASSWORD('${DB_PASS}');" >> /init.sql
echo "GRANT ALL ON *.* TO '$DB_USER'@'127.0.0.1' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION;" >> /init.sql
echo "GRANT ALL ON *.* TO '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION;" >> /init.sql
echo "GRANT ALL ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION;" >> /init.sql
echo "FLUSH PRIVILEGES;" >> /init.sql

mysqld --console --init_file=/init.sql