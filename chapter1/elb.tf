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

resource "aws_security_group" "elb_sg" {
  name = "terraform-elb-ingress"
  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Inbound HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}