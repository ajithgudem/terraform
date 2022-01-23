output "elb_dns_name" {
  value       = aws_elb.instance_elb.dns_name
  description = "The domain name of the load balancer"
}