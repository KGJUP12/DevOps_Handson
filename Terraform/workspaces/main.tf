provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "name_0" {
  ami           = var.ami
  instance_type = lookup(var.instance_type,terraform.workspace,"ERROR NO SUCH WORKSPACE")
  tags = {
    Name=var.Name
  }
}
variable "Name" {
  
}
variable "ami" {
}
variable "instance_type" {
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "stage"= "t2.micro"
    "prod"="t2.micro"
  }
}

# resource "aws_s3_bucket" "fetchedBucket" {
#   bucket = data.aws_s3_bucket.fetch.id
# }