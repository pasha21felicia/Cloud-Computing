output "mysql_aurora_ipv4_sg_rule_id" {
  description = "The ID of the MySQL Aurora IPv4 security group rule"
  value       = aws_security_group_rule.mysql_aurora_ipv4.id
}

output "app_news_db_subnet_group_name" {
  description = "The name of the app_news RDS database subnet group"
  value       = aws_db_subnet_group.app_news.name
}