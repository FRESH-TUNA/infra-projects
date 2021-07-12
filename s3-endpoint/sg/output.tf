output "bastion_ec2_id" {
  value = aws_security_group.bastion_ec2.id
}

output "s3_access_ec2_id" {
  value = aws_security_group.s3_access_ec2.id
}
