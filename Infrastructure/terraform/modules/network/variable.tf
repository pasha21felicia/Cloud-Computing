variable "mysql_aurora_ipv4_cidr" {
  default = "0.0.0.0/0"
}

variable "db_subnet_ids" {
  default = ""
}

variable "mysql_security_group_id" {
  default = "sg-04aa2fb9aa82e61b6"
}

