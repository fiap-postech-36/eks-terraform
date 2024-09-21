terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

module "cluster-eks-fiap" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "cluster-eks-fiap"
  cluster_version = "1.23"
  subnets         = [
    "subnet-0af1a2b0c4e87a8de",
    "subnet-09bbc7703c198652c",
    "subnet-0e7c53c46d04ec3e5",
    "subnet-052032e23566308d6",
    "subnet-0121249a88ef4bc0a",
    "subnet-09da51e5d063c8baf"
  ]
  vpc_id          = "vpc-048be7ca8808d1272"
  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }
}

output "cluster_endpoint" {
  value = module.cluster-eks-fiap
}

output "cluster_name" {
  value = module.cluster-eks-fiap.cluster_id
}

output "node_group_role" {
  value = module.eks.node_groups["eks_nodes"].iam_role_arn
}