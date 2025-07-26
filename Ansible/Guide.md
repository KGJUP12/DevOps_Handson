ssh-copy-id -f "-o IdentityFile ~/SecretAWSAccess.pem" ubuntu@43.204.235.192

While executing it i faced issues due to my aws.pem file had open permissions.
as wsl user i moved it into the home directory and then executed chmod 600 to updated permissions.

after success do ssh <ipaddress> and check if u can log in.


ansible-adhoc commands
ansible -i inventory.ini -m "shell" -a "echo hello" slave1
    -i inventory file location 
    -m module  {shell is shell terminal}
    -a arguments to module "echo hello" 
    slave1 is the host or group from inventory to target