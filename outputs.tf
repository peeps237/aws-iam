output "iam_role_arn" {
  value       = aws_iam_role.main.arn
  description = "The ARN of the IAM Role"
}

output "iam_instance_profile" {
  description = "Name of the ec2 profile (if enabled)"
  value       = join("", aws_iam_instance_profile.default.*.name)
}

output "iam_role_name" {
  value       = aws_iam_role.main.name
  description = "Name of the IAM Role"
}
