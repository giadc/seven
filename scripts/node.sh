#!/usr/bin/env bash

# Node
################
sudo curl --silent --location https://rpm.nodesource.com/setup_5.x | sudo bash -

sudo yum -y erase /etc/yum.repos.d/nodesource-el.repo
sudo yum install -y gcc-c++ make
sudo yum -y install nodejs npm
