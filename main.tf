resource "aws_instance" "Terraform_Created_Instance" {
  count                  = 2
  ami                    = "ami-0ba259e664698cbfc"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Terraform_Created_Security_Group.id]
  subnet_id              = aws_subnet.Terraform_Created_Subnet_1a.id
  tags = {
    Name = "Terraform-Created-Instance"
  }
}

