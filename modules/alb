module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 9.0"

  name    = "my-alb"
  vpc_id  = aws_vpc.main.id
  subnets = aws_subnet.public[*].id

  security_groups = [aws_security_group.alb.id]

  enable_deletion_protection = false

  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"

      forward = {
        target_group_key = "app"
      }
    }
  }

  target_groups = {
    app = {
      name_prefix      = "app"
      protocol         = "HTTP"
      port             = 8080
      target_type      = "instance"
      create_attachment = false
    }
  }

  tags = {
    Environment = "dev"
    Project     = "demo"
  }
}
