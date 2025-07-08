terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "Provisioners Demo"
  public_key = file("/home/ubuntu/.ssh/id_rsa")
}

resource "aws_vpc" "provisioner_VPC" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.provisioner_VPC.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "IGW1" {
  vpc_id = aws_vpc.provisioner_VPC.id
}

resource "aws_route_table" "RT1" {
  vpc_id = aws_vpc.provisioner_VPC
  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW1.id
  }
}

resource "aws_route_table_association" "RouteMapping" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.RT1.id
}


resource "aws_security_group" "SGW1" {
  vpc_id = aws_vpc.provisioner_VPC.id
  name   = "web"
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }

  tags = {
    Name = "Web-sg"
  }
}

resource "aws_instance" "Server" {
  ami                    = "ami-0f918f7e67a3323f0"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.SGW1.id]
  subnet_id              = aws_subnet.subnet1.id

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/ubuntu/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "app.py"
    destination = "/home/ubuntu/app.py"
  }

  provisioner "remote_exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",                  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip", # Example package installation
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "nohup sudo python3 app.py &",
    ]
  }
}
