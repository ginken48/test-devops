output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.main.id
}

output "ec2_public_ip" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.main.public_ip
}

output "ec2_public_dns" {
  description = "EC2 Instance Public DNS"
  value       = aws_instance.main.public_dns
}

output "ssh_command" {
  description = "SSH command to connect to EC2"
  value       = "ssh -i <your-key.pem> ec2-user@${aws_instance.main.public_ip}"
}

output "graphite_url" {
  description = "Graphite Web UI URL"
  value       = "http://${aws_instance.main.public_ip}:8088"
}
