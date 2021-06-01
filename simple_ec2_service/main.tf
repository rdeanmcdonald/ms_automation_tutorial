provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "avs" {
  ami           = "ami-03eaf3b9c3367e75c"
  instance_type = "t2.micro"
  key_name      = "avs"

  vpc_security_group_ids = [aws_security_group.avs.id]

  tags = {
    Name = "AnythingCanGoHere"
    Sample = "This too"
  }
}

resource "tls_private_key" "avs" {
  algorithm = "RSA"
}

resource "aws_key_pair" "avs" {
  key_name   = "avs"
  public_key = tls_private_key.avs.public_key_openssh
}

resource "aws_security_group" "avs" {
  name        = "avs"
  description = "avs firewall"

  tags = {
    Name = "avs"
  }

  # Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow ACH Service Traffic
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
