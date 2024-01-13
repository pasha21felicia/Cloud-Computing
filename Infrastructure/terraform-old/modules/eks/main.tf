resource "aws_eks_cluster" "k8s-acc" {
  name     = var.cluster_name
  role_arn = var.cluster_iam_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

resource "aws_eks_node_group" "k8s-acc" {
  cluster_name    = aws_eks_cluster.k8s-acc.name
  node_group_name = var.cluster_name
  node_role_arn   = var.node_iam_role_arn
  subnet_ids      = var.subnet_ids
  instance_types  = var.instance_types

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 1
  }
}