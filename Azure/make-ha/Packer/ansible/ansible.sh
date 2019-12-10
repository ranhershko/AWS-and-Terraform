#!/bin/bash -x


sudo yum update -y
sudo apt-cache madison python3 aptitude python3-pip
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade python3 aptitude python3-pip -y
sudo -H pip3 install ansible

