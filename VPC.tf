#Create a VPC
resource "aws_vpc" "Terraform_Created" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Terraform_Created_VPC"
  }
}

#Create a subnet
resource "aws_subnet" "Terraform_Created_Subnet_1a" {
  vpc_id                  = aws_vpc.Terraform_Created.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
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

#Create a route table association
resource "aws_route_table_association" "Terraform_Created_Route_Table_Association" {
  subnet_id      = aws_subnet.Terraform_Created_Subnet_1a.id
  route_table_id = aws_route_table.Terraform_Created_Route_Table.id
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
    description = "Allow SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Project port from VPC"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all traffic from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}