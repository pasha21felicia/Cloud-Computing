# Data sources
data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

locals {
  ecr_backend_image  = "${var.account_number}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_backend}:latest"
  ecr_frontend_image = "${var.account_number}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_frontend}:latest"
}


provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

resource "kubernetes_secret" "backend_secrets" {
  metadata {
    name = "backend-secrets"
  }

  data = {
    DB_ENDPOINT=var.db_endpoint_custom
    DATABASE_NAME=var.db_name
    DB_PASSWORD=var.db_password
    DB_USER=var.db_username
    ACCESS_KEY=var.access_key
    SECRET_KEY=var.secret_key
    REGION=var.aws_region
    JWT_SECRET_KEY=var.jwt_secret_key
    BUCKET_NAME=var.bucket_name
  }

  type = "Opaque"
}


# Start defining BACKEND deployment and service
resource "kubernetes_deployment" "appnews_backend_deployment" {
  metadata {
    name = "appnews-backend-deployment"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "appnews-backend"
      }
    }
    template {
      metadata {
        labels = {
          app = "appnews-backend"
        }
      }
      spec {
        container {
          name              = "appnews-backend"
          image             = local.ecr_backend_image
          image_pull_policy = "Always"
          port {
            container_port = 8000
          }
          env {
            name = "ACCESS_KEY"
            value_from {
              secret_key_ref {
                name     = kubernetes_secret.backend_secrets.metadata.0.name
                key      = "ACCESS_KEY"
                optional = false
              }
            }
          }
          env {
            name = "SECRET_KEY"
            value_from {
              secret_key_ref {
                name     = kubernetes_secret.backend_secrets.metadata.0.name
                key      = "SECRET_KEY"
                optional = false
              }
            }
          }
          env {
            name = "DB_ENDPOINT"
            value_from {
              secret_key_ref {
                name     = kubernetes_secret.backend_secrets.metadata.0.name
                key      = "DB_ENDPOINT"
                optional = false
              }
            }
          }
          env {
            name = "DATABASE_NAME"
            value_from {
              secret_key_ref {
                name     = kubernetes_secret.backend_secrets.metadata.0.name
                key      = "DATABASE_NAME"
                optional = false
              }
            }
          }
          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                name     = kubernetes_secret.backend_secrets.metadata.0.name
                key      = "DB_PASSWORD"
                optional = false
              }
            }
          }
          env {
            name = "DB_USER"
            value_from {
              secret_key_ref {
                name     = kubernetes_secret.backend_secrets.metadata.0.name
                key      = "DB_USER"
                optional = false
              }
            }
          }
          env {
            name = "DB_USER"
            value_from {
              secret_key_ref {
                name     = kubernetes_secret.backend_secrets.metadata.0.name
                key      = "DB_USER"
                optional = false
              }
            }
          }
          env {
            name = "REGION"
            value_from {
              secret_key_ref {
                name     = kubernetes_secret.backend_secrets.metadata.0.name
                key      = "REGION"
                optional = false
              }
            }
          }
          env {
            name = "JWT_SECRET_KEY"
            value_from {
              secret_key_ref {
                name     = kubernetes_secret.backend_secrets.metadata.0.name
                key      = "REGION"
                optional = false
              }
            }
          }
          env {
            name = "BUCKET_NAME"
            value_from {
              secret_key_ref {
                name     = kubernetes_secret.backend_secrets.metadata.0.name
                key      = "BUCKET_NAME"
                optional = false
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "appnews_backend_service" {
  metadata {
    name = "appnews-backend-service"
  }
  spec {
    type = "ClusterIP"
    selector = {
      app = "appnews-backend"
    }
    port {
      name        = "http"
      port        = 8000
      target_port = 8000
    }
  }
}

# Start defining NGINX deployment and service to serve as proxy for BACKEND
resource "kubernetes_deployment" "nginx_deployment" {
  metadata {
    name = "nginx-deployment"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "nginx"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }
      spec {
        volume {
          name = "nginx-conf"

          config_map {
            name = "nginx-conf"
          }
        }
        container {
          name  = "nginx"
          image = "nginx:stable-alpine"
          port {
            container_port = 80
          }
          volume_mount {
            name       = "nginx-conf"
            mount_path = "/etc/nginx/nginx.conf"
            sub_path   = "nginx.conf"
          }
        }
      }
    }
  }
}

resource "kubernetes_config_map" "nginx_conf" {
  metadata {
    name = "nginx-conf"
  }
  #   "nginx.conf" = file("${path.module}/nginx.conf")
  data = {
    "nginx.conf" = file("/Users/parascoviadigori/Documents/Infrastructure/eks/nginx/nginx.conf")
  }
}

resource "kubernetes_service" "nginx_service" {
  metadata {
    name = "nginx-service"
  }
  spec {
    type = "LoadBalancer"

    selector = {
      app = "nginx"
    }
    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }
  }
}

# Start defining FRONTED deployment and service
resource "kubernetes_deployment" "appnews_frontend" {
  metadata {
    name = "appnews-frontend-deployment"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "appnews-frontend"
      }
    }
    template {
      metadata {
        labels = {
          app = "appnews-frontend"
        }
      }
      spec {
        container {
          name              = "appnews-frontend"
          image             = local.ecr_frontend_image
          image_pull_policy = "Always"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "appnews_frontend_deployment" {
  metadata {
    name = "appnews-frontend-service"
  }
  spec {
    selector = {
      app = "appnews-frontend"
    }
    type = "LoadBalancer"
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
  }
}


###############################################################

#resource "kubernetes_namespace" "test" {
#  metadata {
#    name = "nginx"
#  }
#}
#resource "kubernetes_deployment" "test" {
#  metadata {
#    name      = "nginx"
#    namespace = kubernetes_namespace.test.metadata.0.name
#  }
#  spec {
#    replicas = 1
#    selector {
#      match_labels = {
#        app = "MyTestApp"
#      }
#    }
#    template {
#      metadata {
#        labels = {
#          app = "MyTestApp"
#        }
#      }
#      spec {
#        container {
#          image = "nginx"
#          name  = "nginx-container"
#          port {
#            container_port = 80
#          }
#        }
#      }
#    }
#  }
#}
#resource "kubernetes_service" "test" {
#  metadata {
#    name      = "nginx"
#    namespace = kubernetes_namespace.test.metadata.0.name
#  }
#  spec {
#    selector = {
#      app = kubernetes_deployment.test.spec.0.template.0.metadata.0.labels.app
#    }
#    type = "LoadBalancer"
#    port {
#      port        = 80
#      target_port = 80
#    }
#  }
#}


