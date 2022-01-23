data "aws_availability_zones" "available" {
    state = "available"
}

resource "aws_launch_configuration" "instance_asg" {
  image_id        = "ami-0c55b159cbfafe1f0"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance-sg.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_http_port}" &
              EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "instance_asg_group" {
  launch_configuration  = aws_launch_configuration.instance_asg.id
  availability_zones    = data.aws_availability_zones.available.names
  
  load_balancers    = [aws_elb.instance_elb.name]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10
  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

