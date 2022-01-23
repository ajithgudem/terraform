resource "aws_elb" "instance_elb" {
  name               = "terraform-elb-example"
  security_groups    = [aws_security_group.elb_sg.id]
  availability_zones = data.aws_availability_zones.available.names
  
  # This adds a listener for incoming HTTP requests.
  listener {
    lb_port           = var.elb_http_port
    lb_protocol       = "http"
    instance_port     = var.server_http_port
    instance_protocol = "http"
  }

  # health check
  health_check {
    target              = "HTTP:${var.server_http_port}/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
  }
}