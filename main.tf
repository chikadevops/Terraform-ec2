provider "aws" {
  region = var.region
}

resource "aws_key_pair" "test_key" {
  key_name   = "test_key"
  public_key = var.public_key
}

resource "aws_instance" "test_instance" {
  ami           = var.ami_value
  instance_type = var.instance_type
  key_name      = aws_key_pair.test_key.key_name

  vpc_security_group_ids = var.vpc_security_group_ids
  user_data              = <<-EOF
                #!/bin/bash
                apt update -y
                apt install -y apache2
                systemctl start apache2
                systemctl enable apache2
                echo "<h1>Hello World from $(hostname -f)</h1>" . /var/www/html/index.html
                EOF

  tags = {
    Name = "test_instance"
  }
}
