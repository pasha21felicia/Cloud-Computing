db_root_password     = "rootpass"
db_user              = "admin"
db_password          = "adminpass"
db_name              = "app_news"
db_volume_path       = "/mnt/data"
db_volume_mount_path = "/var/lib/mysql"
db_access_modes      = "ReadWriteMany"
db_storage           = "5Gi"

jwt_secret_key = "8bf194eca505a14a48a079410fdbd100"

vue_app_backend_url = "http://backend-service:8000"
vue_app_auth_url    = "http://authentification-service:8001"

frontend_iamge = "pashadigori2000/cloud-computing:frontend-image-v1.0"
backend_image  = "pashadigori2000/cloud-computing:backend-image-v1.0"
auth_image     = "pashadigori2000/cloud-computing:auth-image-v1.0"
adminer_image  = "adminer:4.7.6-standalone"
mysql_image    = "mysql:8.0"

ingress_adminer_url  = "adminer.k8s.com"
ingress_frontend_url = "frontend.k8s.com"

adminer_design         = "pepa-linha"
adminer_default_server = "mysql-service"
