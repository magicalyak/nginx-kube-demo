Role Name
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

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

Apache 2.0

Author Information
------------------

Tom Gamull tom.gamull@nginx.com https://github.com/magicalyak
