variable "cluster_name" {
  description = "The EKS cluster name"
  type        = string
}
variable "cluster_iam_role_arn" {
  description = "The IAM Role ARN for the EKS cluster"
  default     = ""
}

variable "cluster_policy_attachment_id" {
  description = "The ID of the AmazonEKSClusterPolicy IAM role policy attachment"
  default     = ""
}

variable "vpc_resource_controller_attachment_id" {
  description = "The ID of the AmazonEKSVPCResourceController IAM role policy attachment"
  default     = ""
}

variable "node_iam_role_arn" {
  description = "The IAM Role ARN for the EKS worker nodes"
  default     = ""
}

variable "worker_node_policy_attachment_id" {
  description = "The ID of the AmazonEKSWorkerNodePolicy IAM role policy attachment"
  default     = ""
}

variable "cni_policy_attachment_id" {
  description = "The ID of the AmazonEKS_CNI_Policy IAM role policy attachment"
  default     = ""
}

variable "ecr_read_only_policy_attachment_id" {
  description = "The ID of the AmazonEC2ContainerRegistryReadOnly IAM role policy attachment"
  default     = ""
}

variable "subnet_ids" {
  description = "The subnet IDs"
  default     = ""
}

variable "instance_types" {
  description = "The  worker nodes instance types"
  default     = ""
}

