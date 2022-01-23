resource "aws_security_group" "instance-sg" {
    name = "terraform-instance-ingress"
    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "allow-http"
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
  tags = {
        Name = "allow-http"
    }
}
