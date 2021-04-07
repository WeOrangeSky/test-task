#!/bin/sh

if [ ! -d "/run/mysqld/" ]; then
    echo 'Creating directory'
    mkdir -p /run/mysqld/
    chown -R mysql:mysql /run/mysqld/
fi

echo 'Deploing default schema'
mysql_install_db --user=mysql --ldata=/var/lib/mysql/ > /dev/null

echo 'Create SQL file, with all privileges to $MYSQL_USER'
cat << EOF > grant.sql
USE mysql; 
FLUSH PRIVILEGES;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

echo 'Granting privileges'
mysqld --user=root --bootstrap --silent-startup < grant.sql

echo 'Adjustment default configuration'
sed -i '/^skip-networking/d' /etc/my.cnf.d/mariadb-server.cnf
sed -i 's/^#bind/bind/' /etc/my.cnf.d/mariadb-server.cnf
rm grant.sql

sleep 5