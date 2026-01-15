resource "aws_db_subnet_group" "sub-grp" {
  provider = aws.secondary
  name       = "main-us-east-2"
  subnet_ids = [aws_subnet.prvt7.id, aws_subnet.prvt8.id]
  depends_on = [ aws_subnet.prvt7,aws_subnet.prvt8 ]

  tags = {
    Name = "My-DB-subnet-group"
  }
}