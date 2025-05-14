provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "test_key" {
  key_name   = "test_key"
  public_key = file("/home/haelz/MyEC2Key.pub")
}

resource "aws_instance" "test_instance" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.test_key.key_name

  vpc_security_group_ids = ["sg-06e52eddcf9ece437"]

  user_data = <<-EOF
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
