resource "aws_eks_cluster" "cluster" {
  name     = "var.cluster_name"
  role_arn = var.arn

  vpc_config {
    subnet_ids = [
      "172.31.16.0/20",
      "172.31.0.0/20",
      "172.31.80.0/20",
      "172.31.32.0/20"
    ]
  }
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = aws_eks_cluster.cluster.name
}

# EKS Node Group
resource "aws_eks_node_group" "node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "node_group"
  node_role_arn   = var.arn
  subnet_ids      = [
      "172.31.80.0/20",
      "172.31.32.0/20"
  ]

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }

  lifecycle {
    prevent_destroy = false
  }

  instance_types = [var.instance_type]
  disk_size      = 20

  ami_type = "AL2_x86_64"

  depends_on = [aws_eks_cluster.cluster]
}

# Security group to EKS Cluster
resource "aws_security_group" "eks_security_group" {
  vpc_id = aws_vpc.vpc_restaurante.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
