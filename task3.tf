resource "aws_security_group" "web_server_sg" {
  name        = "web_server_sg"
  description = "Security group for web servers EC2 instance"
  vpc_id      = aws_vpc.devops_vpc.id  


  ingress { #Http access from anywhere 
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict to specific IPs/CIDRs if needed

  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict if required 
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  #IP access avalible for myself from anaywhere and also for 2020447
  }

  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic by default
  }
}
