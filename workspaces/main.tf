provider "aws" {
  region = "us-east-1"
}

variable "ec2_instance_ami" {
  description = "this is an AMI for the ec2 instance"
}

variable "ec2_instance_type" {
  description = "this is a type of ec2 instance"
  type        = map(string)
  default = {
    "dev"   = "t2.micro"
    "stage" = "t2.medium"
    "prod"  = "t2.large"
  }
}


module "aws_instances" {
  source        = "./modules/ec2_instances"
  instance_ami  = var.ec2_instance_ami
  instance_type = lookup(var.ec2_instance_type, terraform.workspace, "ERROR: No instance type defined for this workspace")
}
