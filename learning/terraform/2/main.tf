// Creates a single instance in AWS with Relevant tags

provider "aws" {
  region  = "ap-southeast-2" //Sydney
  profile = "sougata"
}

resource "aws_vpc" "terraform2" {
  cidr_block = "10.0.1.0/24" //Smallest VPC CIDR
  tags = {
    "Name"        = "Terraform 2 VPC"
    "Cost Center" = "Learning"
    "Project"     = "Terraform"
  }
}

resource "aws_network_interface" "terraform2" {
  subnet_id = "${aws_subnet.terraform2.id}"
  tags = {
    "Name"        = "Terraform 2 Network Interface"
    "Cost Center" = "Learning"
    "Project"     = "Terraform"
  }
}

resource "aws_subnet" "terraform2" {
  vpc_id     = "${aws_vpc.terraform2.id}"
  cidr_block = "10.0.1.0/25"
  tags = {
    "Name"        = "Terraform 2 Subnet"
    "Cost Center" = "Learning"
    "Project"     = "Terraform"
  }
}

resource "aws_default_network_acl" "terraform2" {
  default_network_acl_id = "${aws_vpc.terraform2.default_network_acl_id}"
  subnet_ids             = ["${aws_subnet.terraform2.id}"]
  tags = {
    "Name"        = "Terraform 2 Network ACL"
    "Cost Center" = "Learning"
    "Project"     = "Terraform"
  }
}

resource "aws_default_route_table" "terraform2" {
  default_route_table_id = "${aws_vpc.terraform2.default_route_table_id}"
  tags = {
    "Name"        = "Terraform 2 Route Table"
    "Cost Center" = "Learning"
    "Project"     = "Terraform"
  }
}

resource "aws_default_security_group" "terraform2" {
  vpc_id = "${aws_vpc.terraform2.id}"
  tags = {
    "Name"        = "Terraform 2 Security Group"
    "Cost Center" = "Learning"
    "Project"     = "Terraform"
  }
}

resource "aws_instance" "terraform2" {
  ami           = "ami-0b76c3b150c6b1423" //Ubuntu Server 18.04 LTS (HVM), SSD Volume Type 
  instance_type = "t2.micro"              //1.0 GiB	1 vCPUs
  network_interface {
    network_interface_id = "${aws_network_interface.terraform2.id}"
    device_index         = 0

  }
  volume_tags = {
    "Name"        = "Terraform 2 Volume"
    "Cost Center" = "Learning"
    "Project"     = "Terraform"
  }
  tags = {
    "Name"        = "Terraform 2 Instance"
    "Cost Center" = "Learning"
    "Project"     = "Terraform"
  }
}

