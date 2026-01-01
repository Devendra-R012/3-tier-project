resource "aws_instance" "frontend" {
    ami = var.ami
    instance_type = var.type
    key_name = var.key_name
    user_data = templatefile("./frontend.sh",{})
    associate_public_ip_address = true
    tags = {
       Name = "frontend-server"
    }
}