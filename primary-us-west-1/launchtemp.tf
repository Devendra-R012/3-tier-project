data "aws_ami" "exe" {
  most_recent = true
  owners = [ "self" ]

  filter {
    name = "name"
    values = [ "frontend-ami" ]
  }
  
}

# Launch Template

resource "aws_launch_template" "frontend" {
  name = "frontend-terra"
  description = "frontend-terra"
  image_id = data.aws_ami.exe
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.frontend-server-sg.id]
  key_name = "task" #chnage the key 
  user_data = filebase64("${path.module}/frontend-lt.sh")
  #default_version = 1
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "frontend-terra"
    }
  }
}
  


data "aws_ami" "exe1" {
  most_recent = true
  owners = [ "self" ]

  filter {
    name = "name"
    values = [ "Backend-ami" ]
  }
  
}
resource "aws_launch_template" "backend" {
  name = "backend-terra"
  description = "backend-terra"
  image_id = data.aws_ami.exe1
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.backend-server-sg.id]
  key_name = "task"
  user_data = filebase64("${path.module}/backend-lt.sh")
  #default_version = 1
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "backend-terra"
    }
  }
}  
