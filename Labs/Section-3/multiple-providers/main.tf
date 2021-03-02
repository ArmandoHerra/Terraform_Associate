data "aws_ami" "centos_east" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

data "aws_ami" "centos_west" {
  # Selecting our second provider by referencing it's alias.
  provider = aws.west

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


resource "aws_instance" "east_instance" {
  ami           = data.aws_ami.centos_east.id
  instance_type = "t3.nano"
  tags = {
    Lab = "Multiple Providers"
  }
}


resource "aws_instance" "west_instance" {
  provider      = aws.west
  ami           = data.aws_ami.centos_west.id
  instance_type = "t3.nano"
  tags = {
    Lab = "Multiple Providers"
  }
}
