variable "backend_image_tag" {
  description = "Backend image tag"
  type        = string
  default     = "latest"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_profile" {
  default = "k8-admin"
}

variable "account_number" {
  default = "account_number"
}


#network variables
variable "mysql_aurora_ipv4_cidr" {
  default = "0.0.0.0/0"
}

variable "db_subnet_ids" {
  default = ""
}

# VPC Networking
variable "vpc_id" {
  default = "The ID of the VPC"
}

variable "vpc_name" {
  default = ""
}

variable "private_subnets" {
  default = ""
}

variable "name" {
  default = ""
}

# database RDS

variable "db_allocated_storage" {
  default = 20
}

variable "db_instance_class" {
  default = "db.t2.micro"
}

variable "db_username" {
  default = "root"
}

variable "db_password" {
  default = "app_news"
}

variable "db_parameter_group_name" {
  default = "default.mysql8.0"
}

variable "db_backup_retention_period" {
  default = 7
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "8.0"
}

variable "db_name" {
  default = "app_news"
}

variable "db_identifier" {
  default = "dbappnews"
}

variable "db_endpoint_custom" {
  type        = string
  description = "The database endpoint"
}

variable "db_subnet_group_name" {
  default = ""
}

variable "publicly_accessible" {
  default = ""
}

variable "skip_final_snapshot" {
  default = ""
}

# ECR

variable "ecr_frontend" {
  default = ""
}

variable "ecr_backend" {
  default = ""
}

# EKS cluster

variable "cluster_name" {
  default = "mycluster"
}

variable "eks_instance_types" {
  default = ["t2.micro"]
}

# s3_bucket bucket to store images
variable "bucket_name" {
  default = "app-news-store-images"
}


# AWS account

variable "access_key" {
  default     = ""
  description = "The ACCESS KEY for the aws account"
}

variable "secret_key" {
  default     = ""
  description = "The SECRET KEY for the aws account"
}

# Backend

variable "jwt_secret_key" {
  default     = ""
  description = "The JWT SECRET KEY for the Backend"
}
