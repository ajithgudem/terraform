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
