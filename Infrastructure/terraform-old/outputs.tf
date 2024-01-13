output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The VPC ID"
}

output "subnet_ids" {
  value       = module.vpc.subnet_ids
  description = "The subnet IDs"
}

output "internet_gateway_id" {
  value       = module.vpc.internet_gateway_id
  description = "The internet gateway ID"
}

output "route_table_id" {
  value       = module.vpc.route_table_id
  description = "The route table ID"
}

output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.s3_bucket.bucket_id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3_bucket.bucket_arn
}

