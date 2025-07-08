provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "instance_05" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t2.micro"
  tags = {
    Name = "Backend Example"
  }
}

resource "aws_s3_bucket" "backend_bucket" {
  bucket = "my-bucket-random01"
  force_destroy = true
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
}

module "iam_example_iam-user" {
  source  = "terraform-aws-modules/iam/aws//examples/iam-user"
  version = "5.59.0"
}
