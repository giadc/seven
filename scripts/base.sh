#!/usr/bin/env bash

# Base
################

sudo yum update -y
sudo yum install -y wget telnet git tree zip unzip curl
sudo rpm -Uvh http://yum.spacewalkproject.org/2.4/RHEL/7/x86_64/spacewalk-repo-2.4-3.el7.noarch.rpm
