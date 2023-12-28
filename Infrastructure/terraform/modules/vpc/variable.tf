variable "vpc_name" {
  description = "The VPC name"
  default     = ""
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_blocks" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "cluster_name" {
  description = "The EKS cluster name"
  default     = ""
}

variable "additional_tags" {
  description = "Additional tags to apply to the resources"
  type        = map(string)
  default     = {}
}

variable "mysql_aurora_ipv4_cidr" {
  description = ""
  default     = ""
}

variable "mysql_security_group_id" {
  description = ""
  default     = ""
}
