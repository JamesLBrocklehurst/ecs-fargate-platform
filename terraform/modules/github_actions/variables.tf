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