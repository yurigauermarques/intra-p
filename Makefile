SHELL := /bin/bash
-include .env
-include .env.dev
-include .env.local
-include .env.test
export



export HOST_UID:=$(shell id --user)
export HOST_USER:=$(shell id --user --name)
export HOST_GID:=$(shell id --group)
export HOST_GROUP:=$(shell id --group --name)

CMAKE := $(MAKE) --no-print-directory


# Ansible 
.PHONY: ansible-local-ubuntu-24 ansible-local-ubuntu-25

ansible-local-ubuntu-24:
	ansible-playbook -i ansible/hosts_local.ini ansible/configurar_station_24_04.yml --limit localhost  

ansible-local-ubuntu-25:
	ansible-playbook -i ansible/hosts_local.ini ansible/configurar_station.yml --limit localhost  
# 	--ask-become-pass

ansible-vps:
	ansible-playbook -i ansible/hosts.ini ansible/configurar_vps.yml -u ansible --ask-vault-pass