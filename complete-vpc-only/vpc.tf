provider "aws" {
  region = var.region
}


resource "random_string" "suffix" {
  length  = 4
  special = false
}


################################################################################
# VPC
################################################################################


resource "aws_vpc" "main" {
  cidr_block                = var.vpc_cidr_block
  enable_dns_hostnames      = true
  enable_dns_support        = true  
  tags = {
    Name = "vpc-${var.owner}-${random_string.suffix.result}"
  }
}


################################################################################
# Subnets
################################################################################

#F5 subnets
resource "aws_subnet" "int" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.int_cidr_block
  availability_zone = "${var.region}a"
  tags = {
    Name = "F5 Internal Subnet"
  }
}

#F5 subnets
resource "aws_subnet" "ext" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.ext_cidr_block
  availability_zone = "${var.region}a"
  tags = {
    Name = "F5 External Subnet"
  }
}

#F5 subnets
resource "aws_subnet" "mgmt" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.mgmt_cidr_block
  availability_zone = "${var.region}a"
  tags = {
    Name = "F5 Mgmt Subnet"
  }
}