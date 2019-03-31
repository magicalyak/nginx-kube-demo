#!/bin/bash
cd ../kubespray
vagrant destroy -f
rm inventory/sample/vagrant_ansible_invetory
rm -rf inventory/sample/artifacts
rm ~/.kube/config