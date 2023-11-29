provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
  shared_credentials_files = ["~/.aws/credentials"]
}

resource "aws_launch_configuration" "example" {
  name = "example_config"
  image_id = "ami-0230bd60aa48260c6"  # Specify your AMI ID
  instance_type = "t2.micro"        # Specify your instance type
}

resource "aws_autoscaling_group" "example" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  launch_configuration = aws_launch_configuration.example.id

  vpc_zone_identifier = ["subnet-0052717cf16803699", "subnet-04254d4af0d90de5c"]
  # Specify your subnet ID(s)

  health_check_type          = "EC2"  # Health check type, either "EC2" or "ELB"
  health_check_grace_period  = 300    # Time (in seconds) after an instance comes into service before checking its health
  force_delete               = true   # Allows Terraform to delete an ASG without waiting for instances to terminate

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "example-asg-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  scaling_adjustment      = 1   # Number of instances by which to scale
  cooldown                = 300  # Time (in seconds) after a scaling activity completes before another can start
  name                    = "scale-up"
  autoscaling_group_name  = aws_autoscaling_group.example.name
  adjustment_type         = "ChangeInCapacity"
}

resource "aws_autoscaling_policy" "scale_down" {
  scaling_adjustment      = -1  # Number of instances by which to scale down
  cooldown                = 300  # Time (in seconds) after a scaling activity completes before another can start
  name                    = "scale-down"
  autoscaling_group_name  = aws_autoscaling_group.example.name
  adjustment_type         = "ChangeInCapacity"
}

resource "aws_security_group" "example" {
  name = "example"
  # Define your security group settings
}

