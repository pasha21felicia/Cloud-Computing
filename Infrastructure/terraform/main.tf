resource "kubernetes_secret" "mysql_secret" {
  metadata {
    name = "mysql-secret"
    labels = {
      app = "mysql"
    }
  }
  data = {
    mysql-root-password = var.db_root_password
    mysql-user          = var.db_user
    mysql-password      = var.db_password
    mysql-database      = var.db_name
  }
  type = "Opaque"
}

resource "kubernetes_persistent_volume_claim" "mysql_pvc" {
  metadata {
    name = "mysql-pv-claim"
    labels = {
      app = "mysql"
    }
  }
  spec {
    access_modes = [var.db_access_modes]
    resources {
      requests = {
        storage = var.db_storage # Should match the capacity in mysql_pv
      }
    }
  }
}
resource "kubernetes_persistent_volume" "mysql_pv" {
  metadata {
    name = "mysql-pv-volume"
    labels = {
      type = "local"
      app : "mysql"
    }
  }
  spec {
    capacity = {
      storage = var.db_storage
    }
    access_modes = [var.db_access_modes]
    persistent_volume_source {
      vsphere_volume {
        volume_path = var.db_volume_path
      }
    }
  }
}

resource "kubernetes_deployment" "mysql_deployment" {
  metadata {
    name = "mysql-deployment"
    labels = {
      app = "mysql"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mysql"
      }
    }
    template {
      metadata {
        labels = {
          app = "mysql"
        }
      }
      spec {
        container {
          name  = "mysql-db"
          image = var.mysql_image

          env {
            name = "MYSQL_ROOT_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_secret.metadata[0].name
                key  = "mysql-root-password"
              }
            }
          }
          env {
            name = "MYSQL_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_secret.metadata[0].name
                key  = "mysql-user"
              }
            }
          }
          env {
            name = "MYSQL_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_secret.metadata[0].name
                key  = "mysql-password"
              }
            }
          }
          env {
            name = "MYSQL_DATABASE"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_secret.metadata[0].name
                key  = "mysql-database"
              }
            }
          }
          volume_mount {
            name       = "mysql-persistent-storage"
            mount_path = var.db_volume_mount_path
          }
        }
        volume {
          name = "mysql-persistent-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.mysql_pvc.metadata.0.name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mysql_service" {
  metadata {
    name = "mysql-service"
    labels = {
      app = "mysql"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment.mysql_deployment.metadata.0.labels.app
    }
    port {
      name        = "mysql"
      port        = 3306
      target_port = 3306
    }
    type = "ClusterIP"
  }
}
# ----------------------------------------------------------
# Define Adminer

resource "kubernetes_deployment" "adminer_deployment" {
  metadata {
    name = "adminer-deployment"
    labels = {
      app = "adminer"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "adminer"
      }
    }
    template {
      metadata {
        labels = {
          app = "adminer"
        }
      }
      spec {
        container {
          name  = "adminer"
          image = var.adminer_image
          port {
            container_port = 8080
          }
          env {
            name  = "ADMINER_DESIGN"
            value = var.adminer_design
          }
          env {
            name  = "ADMINER_DEFAULT_SERVER"
            value = "mysql-service"
          }
          resources {
            limits = {
              memory = "256Mi"
              cpu    = "500m"
            }
          }
        }
      }
    }
  }
}

# Define the Adminer Service
resource "kubernetes_service" "adminer_service" {
  metadata {
    name = "adminer-service"
  }

  spec {
    selector = {
      app = "adminer"
    }
    port {
      name        = "http"
      port        = 8080
      target_port = 8080
    }
  }
}

# ----------------------------------------------------------

# Define the Ingress for adminer.k8s.com
resource "kubernetes_service_v1" "ingress_service" {
  metadata {
    name = "ingress-service"
  }
  spec {
    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }
    type = "NodePort"
  }
}

resource "kubernetes_ingress_v1" "ingress_resource" {
  wait_for_load_balancer = true
  metadata {
    name = "ingress-resource"
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = var.ingress_adminer_url
      http {
        path {
          path = "/"
          backend {
            service {
              name = "adminer-service"
              port {
                number = 8080
              }
            }
          }
        }
      }
    }
    rule {
      host = var.ingress_frontend_url
      http {
        path {
          path = "/"
          backend {
            service {
              name = "frontend-service"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}


# ----------------------------------------------------------
# Define Backend
resource "kubernetes_secret" "backend_secret" {
  metadata {
    name = "backend-secret"
    labels = {
      app = "backend"
    }
  }
  data = {
    jwt-secret-key = var.jwt_secret_key
  }
  type = "Opaque"
}

resource "kubernetes_deployment" "backend_deployment" {
  metadata {
    name = "backend-deployment"
    labels = {
      app = "backend"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "backend"
      }
    }
    template {
      metadata {
        labels = {
          app = "backend"
        }
      }
      spec {
        container {
          name  = "backend"
          image = var.backend_image
          port {
            container_port = 8001
          }
          env {
            name = "DB_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_secret.metadata[0].name
                key  = "mysql-user"
              }
            }
          }

          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_secret.metadata[0].name
                key  = "mysql-password"
              }
            }
          }

          env {
            name = "DB_DATABASE"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_secret.metadata[0].name
                key  = "mysql-database"
              }
            }
          }
          env {
            name = "JWT_SECRET_KEY"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.backend_secret.metadata[0].name
                key  = "jwt-secret-key"
              }
            }
          }
          env {
            name  = "DB_URL"
            value = "mysql-service"
          }
          env {
            name  = "ORIGINS_URL"
            value = "frontend-service"
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "backend_service" {
  metadata {
    name = "backend-service"
    labels = {
      app = "backend"
    }
  }
  spec {
    type = "ClusterIP"
    selector = {
      app = "backend"
    }
    port {
      name        = "http"
      port        = 8000
      target_port = 8000
    }
  }
}

#----------------------------------------------------
# Create Authentification service

resource "kubernetes_deployment" "auth_deployment" {
  metadata {
    name = "authentification-deployment"
    labels = {
      app = "authentification"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "authentification"
      }
    }
    template {
      metadata {
        labels = {
          app = "authentification"
        }
      }
      spec {
        container {
          name  = "authentification"
          image = var.auth_image
          port {
            container_port = 8001
          }
          env {
            name = "DB_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_secret.metadata[0].name
                key  = "mysql-user"
              }
            }
          }
          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_secret.metadata[0].name
                key  = "mysql-password"
              }
            }
          }
          env {
            name = "DB_DATABASE"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_secret.metadata[0].name
                key  = "mysql-database"
              }
            }
          }
          env {
            name = "JWT_SECRET_KEY"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.backend_secret.metadata[0].name
                key  = "jwt-secret-key"
              }
            }
          }
          env {
            name  = "DB_URL"
            value = "mysql-service"
          }
          env {
            name  = "ORIGINS_URL"
            value = "frontend-service"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "auth_service" {
  metadata {
    name = "authentification-service"
    labels = {
      app = "authentification"
    }
  }
  spec {
    type = "ClusterIP"
    selector = {
      app = "authentification"
    }
    port {
      name        = "http"
      port        = 8001
      target_port = 8001
    }
  }
}

#--------------------------------------------------------------------

# Define the Kubernetes Deployment for frontend
resource "kubernetes_deployment" "frontend_deployment" {
  metadata {
    name = "frontend-deployment"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "frontend"
      }
    }
    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          name  = "frontend"
          image = var.frontend_iamge
          port {
            container_port = 80
          }
          env {
            name  = "VUE_APP_AUTH_URL"
            value = var.vue_app_auth_url
          }
          env {
            name  = "VUE_APP_BACKEND_URL"
            value = var.vue_app_backend_url
          }
        }
      }
    }
  }
}

# Define the Kubernetes Service for frontend
resource "kubernetes_service" "frontend_service" {
  metadata {
    name = "frontend-service"
  }
  spec {
    selector = {
      app = "frontend"
    }
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
  }
}





