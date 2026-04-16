provider "aws" {
  region = "us-east-1"
}

module "aws_instance" {
  source            = "./ec2_instance"
  ec2_instance_ami  = "ami-0ec10929233384c7f"
  ec2_instance_type = "t2.micro"
}
