#!/bin/bash -x

sudo add-apt-repository universe
sudo apt-get update
sudo apt-get upgrade python3
alias python='/usr/bin/python3'
apt-cache search python3-pip$
sudo DEBIAN_FRONTEND=noninteractive apt-get install python3-pip -y
sudo pip3 install ansible
#sudo ln -s /usr/bin/python3 /usr/bin/python
#sudo apt-get update
#sudo apt-get install software-properties-common
#sudo apt-add-repository --yes --update ppa:ansible/ansible
#sudo DEBIAN_FRONTEND=noninteractive apt-get install python3-jinja2 python3-paramiko python3-httplib2 python3-six python3-crypto python3-setuptools python3-cryptography -y
#sudo DEBIAN_FRONTEND=noninteractive apt-get install python-jinja2 python-yaml python-paramiko python-httplib2 python-six python-crypto python-setuptools sshpass python-cryptography python
#sudo DEBIAN_FRONTEND=noninteractive apt-get install ansible -y
