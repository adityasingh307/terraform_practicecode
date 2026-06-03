provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address          = "http://3.84.113.165:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      secret_id = "623c26c5-10d0-3a20-7520-40aec0d8acbb"
      role_id   = "b48403fa-6e63-5db3-5ae8-7bec5aff7010"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv"
  name  = "test_secret"
}

resource "aws_instance" "vault_secret_instance" {
  ami           = "ami-0ec10929233384c7f"
  instance_type = "t2.small"

  tags = {
    Name         = "vault_secret_instance"
    secret_value = data.vault_kv_secret_v2.example.data["username"]
  }
}
