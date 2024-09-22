output "vpc_id" {
  value       = "${aws_vpc.vpc_restaurante.id}"
}

output "private_subnet_1_id" {
  value       = "${aws_subnet.private_subnet_1.id}"
  description = "This is the first Private Subnet ID for later use"
}

output "private_subnet_2_id" {
  value       = "${aws_subnet.private_subnet_2.id}"
  description = "This is the second Private Subnet ID for later use"
}

output "public_subnet_1_id" {
  value       = "${aws_subnet.public_subnet_1.id}"
  description = "This is the first Public Subnet ID for later use"
}

output "public_subnet_2_id" {
  value       = "${aws_subnet.public_subnet_2.id}"
  description = "This is the second Public Subnet ID for later use"
}

output "app_name" {
  value = kubernetes_service.service_app.metadata[0].name
}