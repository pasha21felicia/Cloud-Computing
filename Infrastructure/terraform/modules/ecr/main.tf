resource "aws_ecr_repository" "backend-image" {
  name = var.ecr_backend
}

resource "aws_ecr_repository" "frontend-image" {
  name = var.ecr_frontend
}