#!/bin/bash -x

sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
#sudo add-apt-repository universe
#sudo add-apt-repository multiverse
sudo apt-get update -y
sudo apt-cache madison python3 aptitude python3-pip
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade python3 aptitude python3-pip -y
sudo -H pip3 install ansible

