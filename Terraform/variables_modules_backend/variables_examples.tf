resource "aws_instance" "variable_ec2" {
  ami = var.ami
  instance_type = var.instance_type
  tags = {
    Name=var.tags
  }
}
provider "aws" {
  region=var.region
}