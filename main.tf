resource "aws_instance" "Terraform_Created_Instance" {
    count = 2
    ami = "ami-0ba259e664698cbfc"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.Terraform-Created-SG.id]
    subnet_id = aws_subnet.Terraform-Created-Subnet.id
    tags = {
        Name = "Terraform-Created-Instance"
    }
}

