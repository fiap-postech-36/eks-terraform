resource "aws_db_instance" "restaurant-instance" {
  identifier           = "restaurant-instance"
  engine               = "postgres"
  engine_version       = "15"
  instance_class       = "db.t3.micro" # Eligible for AWS Free Tier
  allocated_storage    = 20
  username             = var.db-username
  password             = random_password.master_password.result
  publicly_accessible  = true # Enable public accessibility
}

output "security_group_id" {
  value = tolist(aws_db_instance.restaurant-instance.vpc_security_group_ids)[0]
}

output "password" {
  value = random_password.master_password.result
  sensitive = true
}