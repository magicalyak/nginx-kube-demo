# NGINX-kube-demo

Ansible playbook to install and configure NGINX Plus on Kubernetes for a demo.

## Requirements

### kubespray

Use kubespray first and clone into a parallel directory.
There is a sample hosts.ini or inventory file under inventory/group_vars
you want to use the generated vagrant inventory and place it in
`inventory/inventory`

You can also roll your own as below:

This should be run against 3 existing CentOS 7 x64 machines already running as VMs from the host system. The instances should be have the following minimum specs.  Minimally, assign unique FQDN and network MAC/IP to the machines.  For Fusion on a Mac, you may want to use bridge mode or ensure the VMs can communicate with each other before starting.

- k8s-master: 4GB memory and 2 vCPUs
- k8s-node-1: 1GB memory and 1 vCPU
- k8s-node-2: 1GB memory and 1 vCPU

you can add more nodes to the inventory, just extend the inventory group nodes

### Change settings for kubespray

Here are my recommendations to have this work
edit the following
`inventory/mycluster/group_vars/k8s-cluster/k8s-cluster.yml`

and change to

```YAML
# Choose network plugin (cilium, calico, contiv, weave or flannel)
# Can also be set to 'cloud', which lets the cloud provider setup appropriate routing
kube_network_plugin: flannel

# Setting multi_networking to true will install Multus: https://github.com/intel/multus-cni
kube_network_plugin_multus: true
```

In addition you should make the local kubectl be enabled by modifying the following settings in k8s-clust.yml

```YAML
kubectl_localhost: true
kubeconfig_localhost: true
```

Also make the changes in vagrant if you use that.
You need to create the directory and file `vagrant/config.rb` and add settings to it such as
`$os = "centos"`

#### ssh keys

No need to do this if you're using Vagrant because I need to figure that out.  If you roll your own VMs then add the ssh keys.

create a private ssh key if you don't have one yet
for each node copy this and test
`$ ssh-copy-id root@k8s-master.gamull.com`
say yes for trust and enter the root password
then test and ensure you can login without a password
`$ ssh root@k8s-master.gamull.com`

repeat for all nodes

#### running kubespray ansible

Once this is done and the inventory is set go and run the following
if you used vagrant this should have been down on the `vagrant up` command

`ansible-playbook cluster.yml -i inventory/mycluster/hosts.ini --user root --become --become-user=root cluster.yml`

## Role Variables

### Configure inventory

Add the system information gathered above into a file called `inventory`,
or create a new one for the cluster.
Place the `inventory` file into the `./inventory` directory.

For example:

```YAML
[kube-master]
kube-master-test.example.com

[etcd:children]
masters

[kube-node]
kube-minion-test-[1:2].example.com

[k8s-cluster:children]
kube-master
kube-node

[calico-rr]
```

### Configure Cluster options

Look through all of the options in `inventory/group_vars/all.yml` and
set the variables to reflect your needs. The options are described there
in full detail. You must enter the password in there

Then copy your nginx-repo.crt and nginx-repo.key to the `roles/nginx/files/` directory

## Dependencies

Ansible needs to be installed
kubespray needs to be run

## Installation

### Running the playbook

#### dashboard

For the dashboard, run the `deploy-dashboard.yml` playbook from the kubespray directory:

`$ ansible-playbook ../nginx-kube-demo/deploy-dashboard.yml -i inventory/sample/vagrant_ansible_inventory --become --become-user=root`

You can access the page by running this command and copying the address given into the browser
`$ kubectl cluster-info`
you may need to run `$ kubectl proxy` but if may just work for you without starting that (it may already be started)
For extra credit, add this to the ingress controller so you can access it but for now, head over to the page.

once you run this go on the master node and grab the token
`kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')`

then open the dashboard and select token and enter it and you should be good

NB: this is a cluster-admin and should only be for demo/dev purposes

#### nginx ingress controller

After going through the setup and entering in the all.yml, run the `deploy-nginx.yml` playbook:

`$ ansible-playbook ../nginx-kube-demo/deploy-nginx.yml -i inventory/sample/vagrant_ansible_inventory --become --become-user=root`

The directory containing ``myinventory`` file must contain the default ``inventory/group_vars`` directory as well (or its equivalent).
Otherwise variables defined in ``group_vars/all.yml`` will not be set.

## License

Apache 2.0

## Author Information

Tom Gamull tom.gamull@nginx.com <https://github.com/magicalyak>

## Acknowledgements

Information from <https://github.com/kubernetes/contrib/tree/master/ansible> was used
