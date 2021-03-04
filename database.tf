resource "aws_db_instance" "aws-database" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.21"
  instance_class       = "db.t2.micro"
  name                 = "awsdatabase"
  username             = "admin"
  password             = "q1q1q1q1"
  db_subnet_group_name = aws_db_subnet_group.aws-db-subnet.id
  vpc_security_group_ids = [aws_security_group.aws-sg-database.id]
  skip_final_snapshot  = true
  identifier           = "aws-database"
}

