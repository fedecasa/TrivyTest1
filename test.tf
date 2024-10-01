# trivytest.tf

# Specify the provider
provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

# Create a security group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change this to restrict access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe01e"  # Replace with a valid AMI ID
  instance_type = "t2.micro"               # Change instance type as needed

  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "MyInstance"
  }
}
