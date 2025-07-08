provider "aws" {
  region = "ap-south-1"
}

variable "ami" {
  description = "This is AMI"
}

variable "instance_type" {
  description = "No default set just define the instance type"
}

resource "aws_instance" "ec2_01" {
  ami = var.ami
  instance_type = var.instance_type
}