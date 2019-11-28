#!/usr/bin/env bash

pushd /vagrant/ansible/
ansible-playbook deploy-apilb.yml
ansible-playbook deploy-controllers.yml
ansible-playbook deploy-workers.yml
