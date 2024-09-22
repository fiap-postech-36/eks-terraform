resource "aws_vpc" "vpc_restaurante" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.vpc_restaurante.id
  cidr_block        = "subnet_public_1_cidr_block"
  availability_zone = var.subnet_availability_zone_1
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.vpc_restaurante.id
  cidr_block        = "subnet_public_2_cidr_block"
  availability_zone = var.subnet_availability_zone_2
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.vpc_restaurante.id
  cidr_block        = var.subnet_private_1
  availability_zone = var.subnet_availability_zone_1

  tags = {
    Name = "food_private_subnet_1"
  }
}

resource "aws_subnet" "food_private_subnet_2" {
  vpc_id            = aws_vpc.vpc_restaurante.id
  cidr_block        = var.subnet_private_2
  availability_zone = var.subnet_availability_zone_2
}

resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.vpc_restaurante.id
}