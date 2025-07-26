Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.



#########################
Ansible has builtin vault which can be used 
Thus to use it we create a password for vault first (to access vault a secure storage we need password)
     openssl rand -hex 32 > vault.pass
      mv vault.pass ~/.vault_pass.txt
      chmod 600 ~/.vault_pass.txt
Then Create the passwod file for the Ansible where we can store our credentials
    ansible-vault create group_vars/all/pass.yml --vault-password-file ~/.vault_pass.txt
    ansible-vault edit group_vars/all/pass.yml --vault-password-file ~/.vault_pass.txt
and then refer to that file when executing the playbook 
ansible-playbook -i inventory.ini ec2.yml --vault-password-file=~/.vault_pass.txt -vvv





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

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
