output "ec2_public_ip" {
  description = "Public IP address of the React EC2 instance"
  value       = aws_instance.react_server.public_ip
}
