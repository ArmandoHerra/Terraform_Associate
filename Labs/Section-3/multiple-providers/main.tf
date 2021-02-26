data "aws_ami" "centos_east" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS ENA 2002_01-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"] # Canonical
}

data "aws_ami" "centos_west" {
  provider    = aws.west
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS ENA 2002_01-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"] # Canonical
}


resource "aws_instance" "east_instance" {
  ami           = data.aws_ami.centos_east.id
  instance_type = "t3.small"
  tags = {
    Lab = "Multiple Providers"
  }
}


resource "aws_instance" "west_instance" {
  provider      = aws.west
  ami           = data.aws_ami.centos_west.id
  instance_type = "t3.small"
  tags = {
    Lab = "Multiple Providers"
  }
}
