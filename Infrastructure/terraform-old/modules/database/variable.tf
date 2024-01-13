

variable "mysql_security_group_id" {
  default = ""
}


variable "mysql_aurora_ipv4_cidr" {
  default = "0.0.0.0/0"
}

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
  default = "dbappnewsnew"
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