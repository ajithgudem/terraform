
output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}
output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
}
output "elb_dns_name" {
  value       = aws_elb.instance_elb.dns_name
  description = "The domain name of the load balancer"
}
