output "db_endpoint" {
  description = "The endpoint of the app_news RDS database"
  value       = aws_db_instance.app_news.endpoint
}