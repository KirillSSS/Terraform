output "rds_endpoint" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.aws-database.endpoint
}

output "ec2_endpoint" {
  description = "The address of the EC2 instance"
  value       = aws_instance.aws-ec2.public_ip
}