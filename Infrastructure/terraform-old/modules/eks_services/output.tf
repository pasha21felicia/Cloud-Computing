#output "kubernetes_namespace" {
#  value       = kubernetes_namespace.test.metadata.0.name
#  description = "The name of the Kubernetes namespace"
#}

output "kubernetes_deployment" {
  value       = kubernetes_deployment.appnews_backend_deployment.metadata.0.name
  description = "The name of the Kubernetes deployment"
}

output "kubernetes_service" {
  value       = kubernetes_service.appnews_backend_service.metadata.0.name
  description = "The name of the Kubernetes service"
}


