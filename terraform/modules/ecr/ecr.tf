# ECR Repository

resource "aws_ecr_repository" "main" {
  name = "${var.app_name}-ecr-repo"
  image_tag_mutability = "IMMUTABLE"
  force_delete = true
  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "${var.encryption_type}"
  
  }

  tags = {
    Name        = "${var.app_name}-ecr-repo"
    Terraform   = "true"
    Environment = "production"
  }

}

# ECR Lifecycle Policy

resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name

  policy = jsonencode({
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
}