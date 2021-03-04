resource "aws_vpc" "aws-vpc1" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  enable_classiclink = false

  tags = {
    Name = "aws-vpc1"
  }
}

resource "aws_subnet" "aws-subnet1" {
  vpc_id     = aws_vpc.aws-vpc1.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1a"

  tags = {
    Name = "aws-subnet1"
  }
}

resource "aws_subnet" "aws-subnet2" {
  vpc_id     = aws_vpc.aws-vpc1.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1b"

  tags = {
    Name = "aws-subnet2"
  }
}

resource "aws_db_subnet_group" "aws-db-subnet" {
  name       = "aws-db-subnet"
  subnet_ids = [aws_subnet.aws-subnet1.id,aws_subnet.aws-subnet2.id ]

  tags = {
    Name = "aws-db-subnet"
  }
}

resource "aws_internet_gateway" "aws-gateway" {
  vpc_id = aws_vpc.aws-vpc1.id

  tags = {
    Name = "aws-gateway"
  }
}

resource "aws_route_table" "aws-route" {
  vpc_id = aws_vpc.aws-vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-gateway.id
  }

  tags = {
    Name = "aws-route"
  }
}

resource "aws_route_table_association" "aws-route-association1" {
  subnet_id      = aws_subnet.aws-subnet1.id
  route_table_id = aws_route_table.aws-route.id
}

resource "aws_route_table_association" "aws-route-association2" {
  subnet_id      = aws_subnet.aws-subnet2.id
  route_table_id = aws_route_table.aws-route.id
}

resource "aws_security_group" "aws-sg" {
  name        = "aws-sg"
  description = "Allow 80 port"
  vpc_id      = aws_vpc.aws-vpc1.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws-sg"
  }
}

resource "aws_security_group" "aws-sg-database" {
  name        = "aws-sg-database"
  description = "Allow database ports"
  vpc_id      = aws_vpc.aws-vpc1.id

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws-sg-database"
  }
}
