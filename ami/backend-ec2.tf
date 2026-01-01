resource "aws_instance" "backend" {
    ami = var.ami
    instance_type = var.type
    key_name = var.key_name
    user_data = templatefile("./backend.sh",{})
    tags = {
       Name = "Backend-server"
    }
  
}