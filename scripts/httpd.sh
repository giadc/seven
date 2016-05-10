#!/usr/bin/env bash

# Apache
################

sudo yum install -y httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service

sudo mkdir /etc/httpd/sites-available
sudo mkdir /etc/httpd/sites-enabled

# If Dev Environment
if [[ ! -z $1 ]] && [[ $1 -eq 'true' ]]; then
    sudo su - root -c 'echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf'
    sudo su - root -c 'echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf'

    sudo rm -rf /var/www/html
    sudo ln -s /vagrant /var/www/html

    sudo setenforce 0 # Not 100% needed...but prevents the need to reload box directly after provisioning
    sudo sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
    sudo sed -i "s/User apache/User vagrant/" /etc/httpd/conf/httpd.conf
    sudo sed -i "s/Group apache/Group vagrant/" /etc/httpd/conf/httpd.conf
else
    sudo echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf
fi

# If Include Apache Scripts
if [[ ! -z $2 ]] && [[ $2 -eq 'true' ]]; then
    sudo curl https://gist.githubusercontent.com/davidxhill/bbadda9b59e268f3174adc51f49b88cf/raw/8b7b28d92cbfbfaf3ffec1ee8baa55b11d859d8e/httpd.sh -o /home/vagrant/httpd.sh
    sudo echo 'source ~/httpd.sh' >> /home/vagrant/.bash_profile;
fi

sudo apachectl restart
