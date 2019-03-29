NGINX-kube-demo
=========

Ansible playbook to install and configure NGINX Plus on Kubernetes for a demo.

Requirements
------------

This should be run against 3 existing CentOS 7 x64 machines already running as VMs from the host system. The instances should be have the following minimum specs.  Minimally, assign unique FQDN and network MAC/IP to the machines.  For Fusion on a Mac, you may want to use bridge mode or ensure the VMs can communicate with each other before starting.

- k8s-master: 4GB memory and 2 vCPUs
- k8s-node-1: 1GB memory and 1 vCPU
- k8s-node-2: 1GB memory and 1 vCPU

you can add more nodes to the inventory, just extend the inventory group nodes


Role Variables
--------------

### Configure inventory

Add the system information gathered above into a file called `inventory`,
or create a new one for the cluster.
Place the `inventory` file into the `./inventory` directory.

For example:
```sh
[masters]
kube-master-test.example.com

[etcd:children]
masters

[nodes]
kube-minion-test-[1:2].example.com
```

### Configure Cluster options

Look through all of the options in `inventory/group_vars/all.yml` and
set the variables to reflect your needs. The options are described there
in full detail.


Dependencies
------------

Ansible needs to be installed

Installation
------------

## Running the playbook

After going through the setup, run the `deploy-cluster.sh` script from within the `scripts` directory:

`$ cd scripts/ && ./deploy-cluster.sh`

You may override the inventory file by running:

`INVENTORY=myinventory ./deploy-cluster.sh`

The directory containing ``myinventory`` file must contain the default ``inventory/group_vars`` directory as well (or its equivalent).
Otherwise variables defined in ``group_vars/all.yml`` will not be set.

In general this will work on very recent Fedora, rawhide or F21.  Future work to
support RHEL7, CentOS, and possible other distros should be forthcoming.

### Targeted runs

You can just setup certain parts instead of doing it all.

#### Etcd

`$ ./deploy-cluster.sh --tags=etcd`

#### Kubernetes master

`$ ./deploy-cluster.sh --tags=masters`

#### Kubernetes nodes

`$ ./deploy-cluster.sh --tags=nodes`

License
-------

Apache 2.0

Author Information
------------------

Tom Gamull tom.gamull@nginx.com https://github.com/magicalyak

Acknowledgements
----------------

Information from https://github.com/kubernetes/contrib/tree/master/ansible was used
