provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "avs" {
  ami           = "ami-03eaf3b9c3367e75c"
  instance_type = "t2.micro"
  key_name      = "achverificationservice-${random_pet.env.id}"

  tags = {
    Name = "AnythingCanGoHere"
    Sample = "This too"
  }
}

resource "tls_private_key" "avs" {
  algorithm = "RSA"
}

resource "aws_key_pair" "avs" {
  key_name   = "avs-${random_pet.env.id}"
  public_key = tls_private_key.avs.public_key_openssh
}
