output "eks_certificate" {
  value = aws_eks_cluster.k8s-acc.certificate_authority
}

output "eks_arn" {
  value = aws_eks_cluster.k8s-acc.arn
}

output "eks_endpoint" {
  value = aws_eks_cluster.k8s-acc.endpoint
}

output "eks_name" {
  value = aws_eks_cluster.k8s-acc.name
}