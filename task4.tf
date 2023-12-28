resource "aws_instance" "web_server" {
  ami           = "ami-05fb0b8c1424f266b"  #latest Ubuntu AMI ID
  instance_type = "t2.micro"
  key_name      = aws_key_pair.assignment_key.key_name

  # Assigns to the public subnet
  subnet_id = aws_subnet.public_subnet_1.id  # Adjusted based on our subnet configured before 

  vpc_security_group_ids = [aws_security_group.web_server_sg.id]  # security group  configed before

  tags = {
    Name = "Assignment4-EC2-WebServer-1"
  }

  # Upload and execute the SH file
  user_data = file("/Users/ammarfarrukh/Desktop/assignment-4-Devops/apache_installer.sh")

  
   # Enable public IP assignment
  associate_public_ip_address = true
}

resource "aws_instance" "database_or_ml" {
  ami           = "ami-05fb0b8c1424f266b"  # latest Ubuntu AMI ID
  instance_type = "t2.micro"
  key_name      = aws_key_pair.assignment_key.key_name

  # Assigned to the appropriate private subnet
  subnet_id = aws_subnet.private_subnet_1.id  # Adjusted  based on our subnet configured before 

  vpc_security_group_ids = [aws_security_group.web_server_sg.id]  # security group  configed before 

  tags = {
    Name = "Assignment4-EC2-DatabaseOrML-1"
  }

  
  
   # Enable public IP assignment
  associate_public_ip_address = true
}
# Display the output in the console after applying the configuration
output "web_server_url" {
  value = "http://${aws_instance.web_server.public_ip}:80"
  description = "URL to access the web server"
}