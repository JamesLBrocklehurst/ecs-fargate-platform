# Creating AWS IAM OIDC Provider for GitHub Actions

resource "aws_iam_openid_connect_provider" "github_gatus" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

# Creating AWS IAM Role

resource "aws_iam_role" "github_actions" {
  name = "${var.app_name}-github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github_gatus.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:${var.github_username}/${var.github_repo}:*"
          }
        }
      }
    ]
  })

  tags = {
    Name        = "${var.app_name}-github-actions-role"
    Terraform   = "true"
    Environment = "production"
  }
}

# Attaching AWS Managed Policies to the IAM Role

resource "aws_iam_role_policy_attachment" "github_actions_ecr" {
  role       = aws_iam_role.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "github_actions_ecs" {
  role       = aws_iam_role.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_policy" "github_actions_terraform" {
  name        = "${var.app_name}-github-actions-terraform-policy"
  description = "Scoped policy for GitHub Actions Terraform deployments"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.state_bucket}",
          "arn:aws:s3:::${var.state_bucket}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
        ]
        Resource = "arn:aws:dynamodb:eu-west-2:*:table/${var.dynamodb_table}"
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:*",
          "ecs:*",
          "elasticloadbalancing:*",
          "acm:*",
          "route53:*",
          "iam:*",
          "logs:*"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attaching the custom policy to the IAM Role

resource "aws_iam_role_policy_attachment" "github_actions_terraform" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.github_actions_terraform.arn
}