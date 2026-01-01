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
  
}