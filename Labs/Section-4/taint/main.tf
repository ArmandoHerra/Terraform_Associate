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

resource "aws_instance" "instance" {
  ami           = data.aws_ami.centos_east.id
  instance_type = "t3.nano"
  tags = {
    Lab = "Multiple Providers"
  }
}

