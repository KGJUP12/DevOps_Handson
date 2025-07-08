// This is regarding provisoners
Provisioners help execute commands in the build infrastructure

we will create an Ec2 instance and deploy the simple app.py program there
But creating Ec2 doesnt run the program thats where we use the concept of Provisioner

1) we create Ec2 like
   a) Create a VPC
   b) Create a Subnet 
   c) create IGW
   d) create route table and attach teh IGW to it.
   e) now mention all the creations as reference to create EC2 
   f) make a SG and attach it to ec2

2) lastly use the provisioners to complete the task
   a) 3 types of provisioners
      - local exec
      - remote exec
      - file exec