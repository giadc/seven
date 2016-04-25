#!/usr/bin/env bash

# Redis
################
sudo yum install -y redis
sudo systemctl start redis.service
sudo systemctl enable redis.service
