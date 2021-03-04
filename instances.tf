resource "aws_instance" "aws-ec2" {
  ami           = "ami-0932440befd74cdba"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.aws-subnet1.id

  vpc_security_group_ids = [aws_security_group.aws-sg.id]

  key_name = "awstest"

  user_data = file("ubuntu.sh")

  tags = {
    Name = "aws-ec2"
  }
}
