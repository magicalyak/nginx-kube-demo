#!/bin/bash
cd ../kubespray
ansible-playbook ../nginx-kube-demo/deploy-dashboard.yml -i inventory/sample/vagrant_ansible_inventory --become --become-user=root
ansible-playbook ../nginx-kube-demo/deploy-nginx.yml -i inventory/sample/vagrant_ansible_inventory --become --become-user=root
cp inventory/sample/artifacts/admin.conf ~/.kube/config
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
kubectl cluster-info