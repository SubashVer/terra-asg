variable "instance_type" {
  description = "The type of EC2 instance to launch in the Auto Scaling Group"
  type        = string
  default     = "t2.micro"  # Change to your desired instance type
}

variable "ami_id" {
  description = "The ID of the Amazon Machine Image (AMI) to use for the EC2 instances"
  type        = string
  # Specify your AMI ID
}

variable "subnet_ids" {
  description = "A list of subnet IDs in which to place the EC2 instances"
  type        = list(string)
  default     = ["subnet-0052717cf16803699", "subnet-04254d4af0d90de5c"]
}


# Add other variables as needed
