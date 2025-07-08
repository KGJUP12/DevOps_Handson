terraform {
  required_version = ">=1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
  alias  = "mumbai"
}
provider "aws" {
  region = "ap-southeast-1"
  alias  = "singapore"
}

resource "aws_instance" "ec2_1" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = var.instance_type
  tags = {
    Name = "Terraform created Mumbai Ec2"
  }
  provider = aws.mumbai
}

resource "aws_instance" "ec2_2" {
  ami           = "ami-02c7683e4ca3ebf58"
  instance_type = "t2.micro"
  provider      = aws.singapore
  tags = {
    Name     = "Terraform created Singapore Ec2"
    Expected = "Ec2 creation"
  }
}

resource "aws_instance" "ec2_3" {
  provider      = aws.mumbai
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t2.micro"
  tags_all = {
    "Name" = "Manually created Mumbai Ec2"
  }
}
data "aws_ami" "ubuntu" {
  provider    = aws.singapore
  most_recent = true // From all the AMIs that match my filters, give me only the most recently created one 

  filter {
    name   = "name" // this tag is name because below is the name of the official AMI Name procured from AMI in aws 
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20250610*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "ec2_4" {
  provider      = aws.singapore
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
}


