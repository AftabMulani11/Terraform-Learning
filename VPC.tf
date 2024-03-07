#Create a VPC
resource "aws_vpc" "Terraform_Created" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "Terraform_Created_VPC"
  }
}

#Create a subnet
resource "aws_subnet" "Terraform_Created_Subnet_1a" {
  vpc_id            = aws_vpc.Terraform_Created.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "Terraform_Created_Subnet"
  }
}

#Create a internet gateway
resource "aws_internet_gateway" "Terraform_Created_Internet_Gateway" {
  vpc_id = aws_vpc.Terraform_Created.id
  tags = {
    Name = "Terraform_Created_Internet_Gateway"
  }
}

#Create a route table
resource "aws_route_table" "Terraform_Created_Route_Table" {
  vpc_id = aws_vpc.Terraform_Created.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Terraform_Created_Internet_Gateway.id
  }
  tags = {
    Name = "Terraform_Created_Route_Table"
  }
}

#Create a security group
resource "aws_security_group" "Terraform_Created_Security_Group" {
  name        = "Terraform_Created_Security_Group"
  description = "A test Security Group to Check working of Terraform"
  vpc_id      = aws_vpc.Terraform_Created.id

  tags = {
    Name = "allow_tls"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "ssh"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}