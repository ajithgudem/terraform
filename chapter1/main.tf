provider "aws" {
    region = "us-east-2"
}

# resource "aws_instance" "instance" {
#     ami             = "ami-0c55b159cbfafe1f0"
#     instance_type   = "t2.micro" 
#     tags            = {
#         Name = "terraform-instance"
#     }
#     user_data = <<-EOF
#     #!/bin/bash
#     echo "Hello, World" > index.html
#     nohup busybox httpd -f -p "${var.server_http_port}" &
#     EOF

#     vpc_security_group_ids = [aws_security_group.instance-sg.id]
# }

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



# output "public_ip" {
#   value       = aws_instance.instance.public_ip
#   description = "The public IP of the web server"
# }