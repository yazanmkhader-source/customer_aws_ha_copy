

# VPC ID used for BIG-IP Deploy
output "vpc_id" {
  value = aws_vpc.main.id
}

