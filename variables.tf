variable "aws_region" {
  default = "us-east-1"
  description = "AWS Region"
}

variable "cluster_name" {
  default = "fiap-piloto"
  description = "EKS Cluster Name"
}

variable "node_role_arn" {
  description = "Node role ARN"
  type = string
  sensitive = true
  default  = "arn:aws:iam::013545085409:role/LabRole"
}

variable "db_host" {
  type = string
  default = "dabaseurl:5432"
  description = "Database host"
}

variable "db_name" {
  type = string
  default = "restaurant"
  description = "Database Name"
}

variable "db_user" {
  type = string
  default = "postgres"
  sensitive = true
  description = "Database username"
}

variable "db_password" {
  type = string
  default = "postgres"
  sensitive = true
  description = "Database password"
}