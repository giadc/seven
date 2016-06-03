#!/usr/bin/env bash

# Php
################

# add needed repos*
sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm

sudo yum install -y yum-utils
sudo yum-config-manager --enable remi-php70

sudo yum -y install php70 php70-php-cli php70-php-common php70-php-bcmath php70-php-dba php70-php-devel php70-php-embedded php70-php-fpm php70-php-gd php70-php-imap php70-php-interbase php70-php-intl php70-php-ldap php70-php-mbstring php70-php-mcrypt php70-php-mysql php70-php-odbc php70-php-opcache php70-php-pdo php70-php-pdo_dblib php70-php-pear php70-php-process php70-php-pspell php70-php-recode php70-php-tidy php70-php-xml php70-php-xmlrpc php70-php-pecl-zip.x86_64 
sudo ln -s /usr/bin/php70 /usr/bin/php

sudo systemctl start php70-php-fpm.service
sudo systemctl enable php70-php-fpm.service

sudo cat >> /etc/httpd/conf/httpd.conf << EOF
<FilesMatch \.php$>
         SetHandler "proxy:fcgi://127.0.0.1:9000"
</FilesMatch>
DirectoryIndex /index.php index.php
EOF

# Php Support Packages
################

if [[ ! -z $2 ]] && [[ $2 -eq 'true' ]] ; then
    sudo curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
    sudo chmod +x /usr/local/bin/composer
fi

sudo systemctl restart php70-php-fpm.service
sudo apachectl restart
