data "aws_availability_zones" "available" {
}

resource "aws_vpc" "k8s-acc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    {
      "Name"                                      = var.vpc_name
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    },
    var.additional_tags
  )
}

resource "aws_subnet" "k8s-acc" {
  count = length(var.subnet_cidr_blocks)

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = var.subnet_cidr_blocks[count.index]
  vpc_id                  = aws_vpc.k8s-acc.id
  map_public_ip_on_launch = true

  tags = merge(
    {
      "Name"                                      = var.vpc_name
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
      "kubernetes.io/role/elb"                    = 1
    },
    var.additional_tags
  )
}

resource "aws_internet_gateway" "k8s-acc" {
  vpc_id = aws_vpc.k8s-acc.id

  tags = merge(
    {
      Name = var.vpc_name
    },
    var.additional_tags
  )
}

resource "aws_route_table" "k8s-acc" {
  vpc_id = aws_vpc.k8s-acc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s-acc.id
  }

  tags = merge(
    {
      Name = var.vpc_name
    },
    var.additional_tags
  )
}

resource "aws_route_table_association" "k8s-acc" {
  count = length(var.subnet_cidr_blocks)

  subnet_id      = aws_subnet.k8s-acc[count.index].id
  route_table_id = aws_route_table.k8s-acc.id
}



# Security group for mysql
resource "aws_security_group" "mysql_security_group" {
  name        = "mysql_security_group"
  description = "Security group for MySQL Aurora"
  vpc_id      = aws_vpc.k8s-acc.id
  tags = {
    Name = "mysql_security_group"
  }
}

resource "aws_security_group_rule" "mysql_aurora_ipv4" {
  security_group_id = aws_security_group.mysql_security_group.id

  type        = "ingress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = [var.mysql_aurora_ipv4_cidr]
}

#
resource "aws_db_subnet_group" "app_news" {
  name       = "app-news-db-subnet-group"
  subnet_ids = aws_subnet.k8s-acc[*].id

  tags = {
    Name = "app-news-db-subnet-group"
  }
}
