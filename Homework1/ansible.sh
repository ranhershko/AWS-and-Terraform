#!/bin/bash -eux

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade python-apt-common apt-utils python-jinja2 python-paramiko python-crypto python-cryptography -y
sudo apt-get install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo DEBIAN_FRONTEND=noninteractive apt-get install ansible -y
