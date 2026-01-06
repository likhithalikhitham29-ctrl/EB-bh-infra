variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "connect_instance_id" {
  description = "Amazon Connect Instance ID"
  type        = string
}

variable "default_queue_id" {
  description = "Default queue ID"
  type        = string
}

variable "security_profile_ids" {
  description = "List of security profile IDs for agent"
  type        = list(string)
}

variable "agent_password" {
  description = "Initial password for agent"
  type        = string
  sensitive   = true
}
