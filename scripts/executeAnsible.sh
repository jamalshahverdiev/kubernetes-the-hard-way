#!/usr/bin/env bash

pushd /vagrant/ansible/
ansible-playbook deploy-kubernetes.yml
