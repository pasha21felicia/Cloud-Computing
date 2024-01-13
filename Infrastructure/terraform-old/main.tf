
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

terraform {
  backend "s3" {
    bucket  = "pasha-bucket-terraform-state-store"
    key     = "terraform/state"
    region  = "eu-central-1"
    profile = "pasha-dev"
  }
}

module "ecr" {
  source       = "./modules/ecr"
  ecr_frontend = var.ecr_frontend
  ecr_backend  = var.ecr_backend
}

module "vpc" {
  source                 = "./modules/vpc"
  cluster_name           = var.cluster_name
  vpc_name               = var.vpc_name
  mysql_aurora_ipv4_cidr = var.mysql_aurora_ipv4_cidr
}

module "database" {
  source = "./modules/database"

  db_allocated_storage    = var.db_allocated_storage
  engine                  = var.engine         #"mysql"
  engine_version          = var.engine_version #"8.0"
  db_instance_class       = var.db_instance_class
  db_name                 = var.db_name #"app_news"
  db_username             = var.db_username
  db_password             = var.db_password
  db_parameter_group_name = var.db_parameter_group_name

  mysql_security_group_id = module.vpc.aws_mysql_security_group

  db_subnet_group_name = module.vpc.app_news_db_subnet_group_name
  publicly_accessible  = true

  db_identifier = var.db_identifier

  db_backup_retention_period = var.db_backup_retention_period
  skip_final_snapshot        = true
  depends_on                 = [module.vpc]
}

module "s3_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = var.bucket_name
}
module "iam" {
  source       = "./modules/eks_iam"
  cluster_name = var.cluster_name
  depends_on   = [module.vpc]
}

module "eks" {
  source                                = "./modules/eks"
  cluster_name                          = var.cluster_name
  instance_types                        = var.eks_instance_types
  cluster_iam_role_arn                  = module.iam.cluster_iam_role_arn
  subnet_ids                            = module.vpc.subnet_ids
  cluster_policy_attachment_id          = module.iam.cluster_policy_attachment_id
  vpc_resource_controller_attachment_id = module.iam.vpc_resource_controller_attachment_id
  node_iam_role_arn                     = module.iam.node_iam_role_arn
  worker_node_policy_attachment_id      = module.iam.worker_node_policy_attachment_id
  cni_policy_attachment_id              = module.iam.cni_policy_attachment_id
  ecr_read_only_policy_attachment_id    = module.iam.ecr_read_only_policy_attachment_id
  depends_on                            = [module.iam]
}

module "eks_services" {
  source             = "./modules/eks_services"
  cluster_name       = module.eks.eks_name
  db_endpoint_custom = var.db_endpoint_custom
  account_number     = var.account_number
  aws_region         = var.aws_region
  ecr_backend        = var.ecr_backend
  ecr_frontend       = var.ecr_frontend

  db_name        = var.db_name
  db_password    = var.db_password
  db_username    = var.db_username
  access_key     = var.access_key
  secret_key     = var.secret_key
  jwt_secret_key = var.jwt_secret_key
  bucket_name    = var.bucket_name
}
