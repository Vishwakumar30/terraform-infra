module "rds" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = "my-rds"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "mydb"
  username = "admin"
  password = "ChangeMe123!"

  publicly_accessible = false
  skip_final_snapshot = true
}
