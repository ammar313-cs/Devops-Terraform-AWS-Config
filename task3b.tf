resource "aws_key_pair" "assignment_key" {
  key_name   = "cs423-assignment4-key"
  public_key = file("/Users/ammarfarrukh/Desktop/assignment-4-Devops/cs423-assignment4-key.pub")
}
 
output "key_name" {
  value = aws_key_pair.assignment_key.key_name
}