provider "aws" {
  region = "ap-south-1"
}

// Create an Custom Ec2 Instance with VPC and Subnet
resource "aws_instance" "my_instance_01" {
  depends_on    = [aws_vpc.aws_specific_vpc]
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t2.micro"
  key_name      = "SecretAWSAccess"
  tags = {
    Name = "CustomInstance"
  }
}

resource "aws_vpc" "aws_specific_vpc" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "aws_specific_vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.aws_specific_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "subnet1"
  }

}

// Create an S3 Bucket 
resource "aws_s3_bucket" "my_s3_bucket_01" {
  bucket = "my-bucket-${random_string.bucketNameGenerator.upper}"
}
output "S3BucketName" {
  value = aws_s3_bucket.my_s3_bucket_01.id
}

resource "random_string" "bucketNameGenerator" {
  length = 5
  special = false 
}



