module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "my-app"

  repository_image_tag_mutability = "IMMUTABLE"

  repository_image_scan_on_push = true

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 10 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
