provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "avs" {
  ami           = "ami-03eaf3b9c3367e75c"
  instance_type = "t2.micro"

  tags = {
    Name = "AnythingCanGoHere"
    Sample = "This too"
  }
}
