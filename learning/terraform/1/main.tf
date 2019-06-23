// Hello World of terraform
// Creates a single instance in AWS 
// How to run 
// terraform init
// terraform plan
// terraform destroy

provider "aws" {
  region = "ap-southeast-2" //Sydney
}

resource "aws_vpc" "terraform1" {
  cidr_block = "10.0.1.0/24" //Smallest VPC CIDR
}

resource "aws_subnet" "terraform1" {
  vpc_id     = "${aws_vpc.terraform1.id}"
  cidr_block = "10.0.1.0/25"
}
resource "aws_instance" "terraform1" {
  ami           = "ami-0b76c3b150c6b1423" //Ubuntu Server 18.04 LTS (HVM), SSD Volume Type 
  instance_type = "t2.micro"              //1.0 GiB	1 vCPUs
  subnet_id     = "${aws_subnet.terraform1.id}"

}

