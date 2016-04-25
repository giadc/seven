#!/usr/bin/env bash

# Beanstalkd
################
sudo yum install -y beanstalkd
sudo systemctl start beanstalkd
sudo systemctl enable beanstalkd
