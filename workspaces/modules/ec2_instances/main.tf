resource "aws_instance" "main" {
  ami           = var.instance_ami
  instance_type = var.instance_type
}
