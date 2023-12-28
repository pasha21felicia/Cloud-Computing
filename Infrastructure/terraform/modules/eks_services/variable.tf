# modules/kubernetes/variables.tf
variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}
variable "db_endpoint_custom" {
  type        = string
  description = "The Endpoint of the RDS instance"
}

variable "account_number" {
  type        = string
  description = "The AWS account number"
}

variable "aws_region" {
  type        = string
  description = "The AWS region"
}

variable "ecr_backend" {
  type        = string
  description = "The ECR repo to store backend images"
}

variable "ecr_frontend" {
  type        = string
  description = "The ECR repo to store frontend images"
}

# eks secrets variables

variable "bucket_name" {
  type        = string
  description = "The s3 bucket name to store images in backend"
}

variable "db_username" {
  type        = string
  description = "The database username"
}

variable "db_password" {
  type        = string
  description = "The database password"
}

variable "db_name" {
  type        = string
  description = "The database name"
}

variable "access_key" {
  type        = string
  description = "The ACCESS KEY for the aws account"
}

variable "secret_key" {
  type        = string
  description = "The SECRET KEY for the aws account"
}

variable "jwt_secret_key" {
  type        = string
  description = "The JWT SECRET KEY for the Backend"
}

#variable "cluster_endpoint" {
#  description = "EKS Cluster Endpoint"
#  type        = string
#}
#
#variable "eks_cluster_certificate_authority" {
#  default = ""
#}
#variable "eks_cluster_token" {
#  description = "EKS Cluster Token"
#  type        = string
#}

