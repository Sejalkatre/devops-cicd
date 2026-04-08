variable "region" {
  default     = "us-west-2"
  description = "AWS region to deploy resources"
}

variable "ami_id" {
  default     = "ami-0d76b909de1a0595d"
  description = "AMI ID for Jenkins EC2"
}

variable "key_name" {
  default     = "devops-key"   # ✅ this must match the key pair name in AWS
  description = "Name of the existing AWS key pair"
}
