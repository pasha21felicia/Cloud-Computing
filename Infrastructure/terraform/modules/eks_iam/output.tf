output "cluster_iam_role_arn" {
  description = "The IAM Role ARN for the EKS cluster"
  value       = aws_iam_role.k8s-acc-cluster.arn
}

output "cluster_policy_attachment_id" {
  description = "The ID of the AmazonEKSClusterPolicy IAM role policy attachment"
  value       = aws_iam_role_policy_attachment.k8s-acc-AmazonEKSClusterPolicy.id
}

output "vpc_resource_controller_attachment_id" {
  description = "The ID of the AmazonEKSVPCResourceController IAM role policy attachment"
  value       = aws_iam_role_policy_attachment.k8s-acc-AmazonEKSVPCResourceController.id
}

output "node_iam_role_arn" {
  description = "The IAM Role ARN for the EKS worker nodes"
  value       = aws_iam_role.k8s-acc-node.arn
}

output "worker_node_policy_attachment_id" {
  description = "The ID of the AmazonEKSWorkerNodePolicy IAM role policy attachment"
  value       = aws_iam_role_policy_attachment.k8s-acc-AmazonEKSWorkerNodePolicy.id
}

output "cni_policy_attachment_id" {
  description = "The ID of the AmazonEKS_CNI_Policy IAM role policy attachment"
  value       = aws_iam_role_policy_attachment.k8s-acc-AmazonEKS_CNI_Policy.id
}

output "ecr_read_only_policy_attachment_id" {
  description = "The ID of the AmazonEC2ContainerRegistryReadOnly IAM role policy attachment"
  value       = aws_iam_role_policy_attachment.k8s-acc-AmazonEC2ContainerRegistryReadOnly.id
}
