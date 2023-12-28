aws_region     = "eu-central-1"
aws_profile    = "pasha-dev"
account_number = "account_number"
#state_bucket_name         = "pasha-bucket-terraform-state-store-manual"
#state_key                 = "terraform/state"
mysql_aurora_ipv4_cidr     = "0.0.0.0/0"
db_name                    = "app_news"
db_identifier              = "dappnewstest"
db_allocated_storage       = 20
db_instance_class          = "db.t2.micro"
db_username                = "root"
db_password                = "app_news"
db_endpoint_custom         = "db.newsncloud.site"
db_parameter_group_name    = "default.mysql8.0"
db_backup_retention_period = 7
cluster_name               = "mycluster"
eks_instance_types         = ["t2.micro"]
vpc_name                   = "vpc-test-mycluster"
ecr_frontend               = "ecr-frontend-image"
ecr_backend                = "ecr-backend-image"
bucket_name                = "app-news-store-images"
jwt_secret_key             = "8bf194eca505a14a48a079410fdbd100"
secret_key                 = "secretkey"
access_key                 = "access_key"