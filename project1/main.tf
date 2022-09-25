provider "aws" {
  region = "us-east-1"
}

# simple aws instance
#resource "aws_instance" "HolovchenkoTestHost" {
#  ami="ami-0cff7528ff583bf9a"
#  instance_type = "t2.micro"
#  tags = {
#    name = "HolovchenkoTestHost"
#    owner = "AHolovchenko"
#  }

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["09"]
}

resource "aws_instance" "HolovchenkoTestHost" {
  ami="ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
  tags = {
    owner = "AHolovchenko"
  }
}