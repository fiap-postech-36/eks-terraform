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
  vpc_id          = "vpc-048be7ca8808d1272"
}

output "cluster_endpoint" {
  value = module.cluster-eks-fiap
}

output "cluster_name" {
  value = module.cluster-eks-fiap.cluster_id
}

output "node_group_role" {
  value = module.cluster-eks-fiap.node_groups["eks_nodes"].iam_role_arn
}