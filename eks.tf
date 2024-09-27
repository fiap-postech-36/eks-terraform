resource "aws_eks_cluster" "restaurant-cluster" {
  name     = var.cluster_name
  role_arn = var.node_role_arn

  vpc_config {
    subnet_ids = module.vpc.private_subnets
    security_group_ids = [aws_security_group.ssh_cluster.id]
  }

  tags = {
    Name = "restaurant_cluster"
  }
}

data "aws_eks_cluster_auth" "restaurant_cluster_auth" {
  name = aws_eks_cluster.restaurant-cluster.name
}

# EKS Node Group
resource "aws_eks_node_group" "restaurant_cluster_group" {
  cluster_name    = var.cluster_name
  node_group_name = "restaurant_node_group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = module.vpc.private_subnets

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }

  lifecycle {
    prevent_destroy = false
  }

  instance_types = ["t2.micro"]
  disk_size      = 20

  ami_type = "AL2_x86_64"

  depends_on = [aws_eks_cluster.restaurant-cluster]
}
