# Replace hard-coded values in the `aws_db_instance` block
resource "aws_db_instance" "app_news" {
  allocated_storage    = var.db_allocated_storage
  engine               = var.engine         #"mysql"
  engine_version       = var.engine_version #"8.0"
  instance_class       = var.db_instance_class
  db_name              = var.db_name #"app_news"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = var.db_parameter_group_name

  vpc_security_group_ids = [var.mysql_security_group_id]

  db_subnet_group_name = var.db_subnet_group_name
  publicly_accessible  = var.publicly_accessible

  identifier = var.db_identifier

  backup_retention_period = var.db_backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
}

resource "null_resource" "import_data" {
  depends_on = [aws_db_instance.app_news]

  triggers = {
    db_endpoint = aws_db_instance.app_news.endpoint
  }

  provisioner "local-exec" {
    command = "bash /Users/parascoviadigori/Documents/Infrastructure/scripts/import_data.sh"
    environment = {
      DB_HOST     = aws_db_instance.app_news.endpoint
      DB_USER     = var.db_username
      DB_PASSWORD = var.db_password
      DB_NAME     = var.db_name
    }
  }
}

