output "Multinucleo_vpc_id" {
  description = "VPC Id"
  value       = aws_vpc.MultinucleoVPC.id
}

output "Multinucleo_public_subnets" {
  description = "Will be used by Web Server Module to set subnet_ids"
  value = [
    aws_subnet.MultinucleoPublicSubnet1,
    aws_subnet.MultinucleoPublicSubnet2
  ]
}

output "Multinucleo_private_subnets" {
  description = "Will be used by RDS Module to set subnet_ids"
  value = [
    aws_subnet.MultinucleoPrivateSubnet1,
    aws_subnet.MultinucleoPrivateSubnet2
  ]
}