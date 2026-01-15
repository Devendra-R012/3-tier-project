data "aws_ami" "exe" {
  provider = aws.secondary
  most_recent = true
  owners      = ["self"] # Replace with the AWS account ID if needed

  filter {
    name   = "name"
    values = ["frontend-ami"] # Use your AMI name pattern
  }
}

# Launch Template Resource
resource "aws_launch_template" "frontend" {
  provider = aws.secondary
  name = "frontend-terraform"
  description = "frontend-terraform"
  image_id = data.aws_ami.exe.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.frontend-server-sg.id]
  key_name = "task-1" 
  user_data = filebase64("${path.module}/frontend-lt.sh")
  #default_version = 1
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "frontend-terraform"
    }
  }
}

###################################################################################
data "aws_ami" "exe1" {
  provider = aws.secondary
  most_recent = true
  owners      = ["self"] # Replace with the AWS account ID if needed

  filter {
    name   = "name"
    values = ["Backend-ami"] # Use your AMI name pattern
  }
}


# Launch Template Resource
resource "aws_launch_template" "backend" {
  provider = aws.secondary
  name = "backend-terraform"
  description = "backend-terraform"
  image_id = data.aws_ami.exe1.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.backend-server-sg.id]
  key_name = "task-1" 
  user_data = filebase64("${path.module}/backend-lt.sh")
  #default_version = 1
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "backend-terraform"
    }
  }
}