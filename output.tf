output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.example.name
}

output "asg_id" {
  description = "The ID of the Auto Scaling Group"
  value       = aws_autoscaling_group.example.id
}

output "launch_config_id" {
  description = "The ID of the Launch Configuration associated with the Auto Scaling Group"
  value       = aws_launch_configuration.example.id
}

# Add other outputs as needed

