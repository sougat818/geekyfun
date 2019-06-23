// Creates a Cloud 9 Dev Environment in AWS

provider "aws" {
  region = "ap-southeast-1" //Singapore
}

resource "aws_vpc" "terraform3" {
  cidr_block = "10.0.1.0/24" //Smallest VPC CIDR
  tags = {
    "Name"        = "Terraform 3 VPC"
    "Cost Center" = "Learning"
    "Project"     = "Terraform"
  }
}

resource "aws_internet_gateway" "terraform3" {
  vpc_id = "${aws_vpc.terraform3.id}"

  tags = {
    "Name"        = "Terraform 3 Gateway"
    "Cost Center" = "Learning"
    "Project"     = "Terraform"
  }
}

resource "aws_subnet" "terraform3" {
  vpc_id                  = "${aws_vpc.terraform3.id}"
  cidr_block              = "10.0.1.0/25"
  map_public_ip_on_launch = "true"
  tags = {
    "Name"        = "Terraform 3 Subnet"
    "Cost Center" = "Learning"
    "Project"     = "Terraform"
  }
}

resource "aws_default_route_table" "terraform3" {
  default_route_table_id = "${aws_vpc.terraform3.default_route_table_id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terraform3.id}"
  }
  tags = {
    "Name"        = "Terraform 3 Route Table"
    "Cost Center" = "Learning"
    "Project"     = "Terraform"
  }
}

resource "aws_route_table_association" "terraform3" {
  subnet_id      = "${aws_subnet.terraform3.id}"
  route_table_id = "${aws_default_route_table.terraform3.id}"
}

resource "aws_cloud9_environment_ec2" "terraform3" {
  instance_type               = "t2.micro" //1.0 GiB	1 vCPUs
  name                        = "GeekyFun"
  automatic_stop_time_minutes = 30
  description                 = "Cloud 9 Dev environment"
  subnet_id                   = "${aws_subnet.terraform3.id}"
}


