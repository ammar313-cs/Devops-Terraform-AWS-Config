# Output for IAM user details
output "iam_user_details" {
  value = {
    name        = aws_iam_user.terraform_user.name
    arn         = aws_iam_user.terraform_user.arn
    path        = aws_iam_user.terraform_user.path
    permissions_boundary = aws_iam_user.terraform_user.permissions_boundary
  }
  description = "IAM user details"
}

# Output for EC2 instance IP addresses
output "instance_ips" {
  value = {
    for instance in [aws_instance.web_server, aws_instance.database_or_ml] :
      instance.tags["Name"] => {  # Key expression added here
        public_ip     = instance.public_ip
        private_ip    = instance.private_ip
      }
  }
  description = "Public and private IP addresses of EC2 instances"
}