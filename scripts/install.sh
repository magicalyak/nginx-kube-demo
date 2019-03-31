#!/bin/bash
cd ../kubespray
ansible-playbook ../nginx-kube-demo/deploy-dashboard.yml -i inventory/sample/vagrant_ansible_inventory --become --become-user=root
ansible-playbook ../nginx-kube-demo/deploy-nginx.yml -i inventory/sample/vagrant_ansible_inventory --become --become-user=root