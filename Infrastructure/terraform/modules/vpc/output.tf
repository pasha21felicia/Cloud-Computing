output "vpc_id" {
  value       = aws_vpc.k8s-acc.id
  description = "The VPC ID"
}

output "subnet_ids" {
  value       = aws_subnet.k8s-acc.*.id
  description = "The subnet IDs"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.k8s-acc.id
  description = "The internet gateway ID"
}

output "route_table_id" {
  value       = aws_route_table.k8s-acc.id
  description = "The route table ID"
}

output "mysql_aurora_ipv4_sg_rule_id" {
  description = "The ID of the MySQL Aurora IPv4 security group rule"
  value       = aws_security_group_rule.mysql_aurora_ipv4.id
}

output "app_news_db_subnet_group_name" {
  description = "The name of the app_news RDS database subnet group"
  value       = aws_db_subnet_group.app_news.name
}

output "aws_mysql_security_group" {
  description = "The name of the app_news RDS database subnet group"
  value       = aws_security_group.mysql_security_group.id
}