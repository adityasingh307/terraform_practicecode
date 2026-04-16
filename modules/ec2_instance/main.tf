provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "test_instance" {
  tags = {
    Name = "test_instance"
  }
  ami           = var.ec2_instance_ami
  instance_type = var.ec2_instance_type
}
