#!/usr/bin/env bash

apt install -y dirmngr git
apt install -y python-pip sshpass && pip install ansible
#echo 'deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main' >> /etc/apt/sources.list
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
#apt update && apt install -y ansible
