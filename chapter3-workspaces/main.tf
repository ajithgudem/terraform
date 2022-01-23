provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "instance" {
    ami             = "ami-0c55b159cbfafe1f0"
    instance_type   = "t2.micro" 
    tags            = {
        Name = "terraform-instance"
    }
    user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p "${var.server_http_port}" &
    EOF

    vpc_security_group_ids = [aws_security_group.instance-sg.id]
}


resource "aws_s3_bucket" "terraform_state" {
  bucket = "agudem-terraform-state"
  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "agudem-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "agudem-terraform-state"
    key            = "workspaces-example/terraform.tfstate"
    region         = "us-east-2"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "agudem-terraform-locks"
    encrypt        = true
  }
}