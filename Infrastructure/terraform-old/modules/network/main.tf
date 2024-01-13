# Replace hard-coded values in the `aws_security_group_rule` block
resource "aws_security_group_rule" "mysql_aurora_ipv4" {
  security_group_id = var.mysql_security_group_id

  type        = "ingress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = [var.mysql_aurora_ipv4_cidr]
}
#
# Replace hard-coded values in the `aws_db_subnet_group` block
resource "aws_db_subnet_group" "app_news" {
  name       = "app-news-db-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "app-news-db-subnet-group"
  }
}