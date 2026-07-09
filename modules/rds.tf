
resource "aws_db_subnet_group" "my-db-subnet-group" {
  name = "my-db-subnet-group"

  subnet_ids = [
    aws_subnet.private-subnet.id,
    aws_subnet.private-subnet-2.id
  ]

  tags = {
    Name = "my-db-subnet-group"
  }
}
resource "aws_security_group" "rds-sg" {
  name        = "rds-sg"
  description = "Security Group for RDS"
  vpc_id      = aws_vpc.my-vpc-1.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}
resource "aws_db_instance" "my-rds" {
  identifier             = "my-rds"
  allocated_storage      = 20
  storage_type           = "gp3"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"

  db_name  = "mydatabase"
  username = "admin"
  password = "Password@123"

  publicly_accessible    = false
  skip_final_snapshot    = true
  deletion_protection    = false

  vpc_security_group_ids = [
    aws_security_group.rds-sg.id
  ]

  db_subnet_group_name = aws_db_subnet_group.my-db-subnet-group.name

  tags = {
    Name = "my-rds"
  }
}
