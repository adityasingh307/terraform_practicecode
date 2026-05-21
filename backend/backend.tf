terraform {
  backend "s3" {
    bucket         = "my-terraform-bucket-example-222"
    region         = "us-east-1"
    key            = "terraform.tfstate"
    dynamodb_table = "terraform-lock"
  }
}
