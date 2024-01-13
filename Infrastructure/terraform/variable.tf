# modules/kubernetes/variables.tf
variable "db_root_password" {
  description = "Root Password for database"
  type        = string
}
variable "db_user" {
  type        = string
  description = "Database user with admin access over database."
}

variable "db_password" {
  type        = string
  description = "Database password"
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_volume_path" {
  type        = string
  description = "Persistent Volume path for storing mysql data"
}
variable "db_access_modes" {
  type        = string
  description = "Access mode for mysql data"
}
variable "db_storage" {
  type        = string
  description = "Persistent Volume storage for storing mysql data"
}
variable "db_volume_mount_path" {
  type        = string
  description = "Persistent Volume Mount path for storing mysql data"
}

variable "jwt_secret_key" {
  type        = string
  description = "JWT Secret key for backend services"
}

variable "vue_app_backend_url" {
  type        = string
  description = "URL to access send requests to backend service"
}

variable "vue_app_auth_url" {
  type        = string
  description = "URL to access send requests to authentification service"
}

variable "frontend_iamge" {
  type        = string
  description = "Frontend image link from dockerhub"
}

variable "backend_image" {
  type        = string
  description = "Backend image link from dockerhub"
}

variable "auth_image" {
  type        = string
  description = "Authentification image link from dockerhub"
}

variable "mysql_image" {
  type        = string
  description = "Mysql official image link from dockerhub"
}

variable "ingress_adminer_url" {
  type        = string
  description = "URL resolved by host machine for adminer in ingress routing"
}

variable "ingress_frontend_url" {
  type        = string
  description = "URL resolved by host machine for frontend in ingress routing"
}

variable "adminer_design" {
  type        = string
  description = "Design theme for adminer"
}
variable "adminer_default_server" {
  type        = string
  description = "Adminer server indicating to mysql-service"
}
variable "adminer_image" {
  type        = string
  description = "Adminer official image"
}