variable "db_username" {
  type        = string
}

variable "db_password" {
  type        = string
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
  default     = "cluster"
}

variable "vpc_name" {
  type        = string
  default     = "vpc-restaurante"
}