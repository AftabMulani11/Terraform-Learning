resource "aws_key_pair" "Terraform_Created_new_keypair" {
  key_name   = "Terraform_Created_key"
  public_key = tls_private_key.Terraform_Created_new_keypair_private.public_key_openssh
}

resource "tls_private_key" "Terraform_Created_new_keypair_private" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "Terraform_Created_new_keypair_private" {
  filename        = "${path.module}/Terraform_Created_key.pem"
  file_permission = "400"
  content         = tls_private_key.Terraform_Created_new_keypair_private.private_key_pem
}

resource "aws_instance" "Terraform_Created_Instance" {
  count                       = 2
  ami                         = "ami-0ba259e664698cbfc"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.Terraform_Created_Security_Group.id]
  subnet_id                   = aws_subnet.Terraform_Created_Subnet_1a.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.Terraform_Created_new_keypair.key_name
  tags = {
    Name = "Terraform-Created-Instance"
  }
}

