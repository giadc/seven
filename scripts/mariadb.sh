#!/usr/bin/env bash

if [[ -z $2 ]]; then
    PASSWORD="root"
else
    PASSWORD="$2"
fi

# MySQL (MariaDB)
################

sudo yum install -y mariadb-server mariadb

sudo systemctl start mariadb
sudo systemctl enable mariadb

# If Dev Environment
if [[ ! -z $1 ]] && [[ $1 -eq 'true' ]]; then
    # Configuring options commonly set through mysql_secure_installation
    sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('$PASSWORD') WHERE User = 'root'"
    sudo mysql -e "DROP USER ''@'localhost'"
    sudo mysql -e "DROP USER ''@'$(hostname)'"
    sudo mysql -e "DROP DATABASE test"
    sudo mysql -e "FLUSH PRIVILEGES"

    # Removes need for ssh tunnel when accessing from host.
    sudo su - root -c 'echo "bind-address = 0.0.0.0" >> /etc/my.conf'
    sudo mysql -u root -proot mysql -e "GRANT ALL ON *.* to root@'%' IDENTIFIED BY 'root'; FLUSH PRIVILEGES;"
else
    sudo mysql_secure_installation
fi

sudo systemctl restart mariadb
