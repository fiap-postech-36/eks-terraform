variable "db_username" {
  type        = string
  default     = "postgres"
}

variable "db_password" {
  type        = string
  default     = "postgres"
}

variable "app_port" {
  type        = string
  default     = "8080"
}

variable "app_target" {
  type        = string
  default     = "30000"
}

variable "arn" {
  type        = string
  sensitive   = true
  default     = "arn:aws:iam::013545085409:role/LabRole"
}

variable "cluster_name" {
  type        = string
  default     = "cluster-restaurante"
}

variable "vpc_name" {
  type        = string
  default     = "vpc-restaurante"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_public_1_cidr_block" {
  description = "CIDR block for the first public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_public_2_cidr_block" {
  description = "CIDR block for the secondary public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "subnet_availability_zone_1" {
  description = "Availability zone for the subnets"
  type        = string
  default     = "us-east-1a"
}

variable "subnet_availability_zone_2" {
  description = "Availability zone 2 for the subnets"
  type        = string
  default     = "us-east-1b"
}

variable "subnet_private_1" {
  description = "CIDR block for the first subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "subnet_private_2" {
  description = "CIDR block for the first subnet"
  type        = string
  default     = "10.0.4.0/24"
}

variable "instance_type" {
  description = "EC2 type"
  type        = string
  default     = "t3.medium"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
}