provider "aws" {
  region = "us-east-1"
}

locals {
  cluster_name = "manual-dev"
}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = local.cluster_name
  }
}

resource "aws_subnet" "public" {
  count = 2

  cidr_block = "10.0.${count.index + 1}.0/24"
  vpc_id     = aws_vpc.this.id

  tags = {
    Name = "${local.cluster_name}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count = 2

  cidr_block = "10.0.${count.index + 101}.0/24"
  vpc_id     = aws_vpc.this.id

  tags = {
    Name = "${local.cluster_name}-private-${count.index + 1}"
  }
}

resource "aws_security_group" "cluster_shared_node" {
  name        = "${local.cluster_name}-cluster-shared-node"
  description = "Communication between all nodes in the cluster"
  vpc_id      = aws_vpc.this.id
}

resource "aws_security_group" "control_plane" {
  name        = "${local.cluster_name}-control-plane"
  description = "Communication between the control plane and worker nodegroups"
  vpc_id      = aws_vpc.this.id
}

resource "aws_eks_cluster" "this" {
  name     = local.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = aws_subnet.private.*.id
  }

  depends_on = [
    aws_security_group_rule.cluster_shared_node,
    aws_security_group_rule.control_plane,
  ]
}

resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_security_group_rule" "cluster_shared_node" {
  security_group_id = aws_security_group.cluster_shared_node.id

  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "control_plane" {
  security_group_id = aws_security_group.control_plane.id

  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/8"]
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_security_group_id" {
  value = aws_security_group.control_plane.id
}

output "cluster_arn" {
  value = aws_eks_cluster
}

resource "aws_security_group_rule" "ingress_default_cluster_to_node_sg" {
  security_group_id = aws_security_group.cluster_shared_node_security_group.id

  description = "Allow managed and unmanaged nodes to communicate with each other (all ports)"
  from_port   = 0
  to_port     = 65535
  protocol    = "-1"

  source_security_group_id = aws_eks_cluster.control_plane.vpc_config[0].cluster_security_group_id
}

resource "aws_security_group_rule" "ingress_inter_node_group_sg" {
  security_group_id = aws_security_group.cluster_shared_node_security_group.id

  description = "Allow nodes to communicate with each other (all ports)"
  from_port   = 0
  to_port     = 65535
  protocol    = "-1"

  source_security_group_id = aws_security_group.cluster_shared_node_security_group.id
}

resource "aws_security_group_rule" "ingress_node_to_default_cluster_sg" {
  security_group_id = aws_eks_cluster.control_plane.vpc_config[0].cluster_security_group_id

  description = "Allow unmanaged nodes to communicate with control plane (all ports)"
  from_port   = 0
  to_port     = 65535
  protocol    = "-1"

  source_security_group_id = aws_security_group.cluster_shared_node_security_group.id
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.stack_name}/InternetGateway"
  }
}

resource "aws_eip" "nat_ip" {
  vpc = true

  tags = {
    Name = "${local.stack_name}/NATIP"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.subnet_public_us_east_1c.id

  tags = {
    Name = "${local.stack_name}/NATGateway"
  }
}

resource "aws_route" "nat_private_subnet_route_us_east_1c" {
  route_table_id         = aws_route_table.private_route_table_us_east_1c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

resource "aws_route" "nat_private_subnet_route_us_east_1d" {
  route_table_id         = aws_route_table.private_route_table_us_east_1d.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

resource "aws_route" "public_subnet_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_vpc" "vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${local.stack_name}/VPC"
  }
}

resource "aws_vpc_gateway_attachment" "vpc_gateway_attachment" {
  vpc_id = aws_vpc.vpc.id
  internet_gateway_id = aws_internet_gateway.internet_gateway.id
}
