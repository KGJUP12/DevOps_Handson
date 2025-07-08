terraform {
  backend "s3" {
    bucket       = "my-bucket-random01"
    key          = "kavindra/terraform/secret/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true

  }
}