variable "app_name" {
  description = "Name of the application, used as a prefix/tag for created resources"
  type        = string
}

variable "github_username" {
  description = "GitHub username for the repository"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "state_bucket" {
  description = "Name of the S3 bucket used for Terraform state"
  type        = string
}

variable "dynamodb_table" {
  description = "Name of the DynamoDB table used for Terraform state locking"
  type        = string
}