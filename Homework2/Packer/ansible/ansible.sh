#!/bin/bash -x

sudo apt-get install python3
sudo ln -s /usr/bin/python3 /usr/bin/python
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo DEBIAN_FRONTEND=noninteractive apt-get install python3-jinja2 python3-paramiko python3-httplib2 python3-six python3-crypto python3-setuptools python3-cryptography -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install ansible -y
