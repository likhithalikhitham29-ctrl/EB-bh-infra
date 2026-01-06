terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

############################
# CONTACT FLOW
############################
resource "aws_connect_contact_flow" "basic_flow" {
  instance_id = var.connect_instance_id
  name        = "Basic-Inbound-Flow"
  type        = "CONTACT_FLOW"
  description = "Simple inbound contact flow"

  content = file("${path.module}/contact_flow.json")
}

############################
# HOURS OF OPERATION
############################
resource "aws_connect_hours_of_operation" "business_hours" {
  instance_id = var.connect_instance_id
  name        = "Business-Hours"
  description = "9am–5pm business hours"
  time_zone   = "UTC"

  config {
    day = "MONDAY"
    start_time { hours = 9 minutes = 0 }
    end_time   { hours = 17 minutes = 0 }
  }

  config {
    day = "TUESDAY"
    start_time { hours = 9 minutes = 0 }
    end_time   { hours = 17 minutes = 0 }
  }
}

############################
# ROUTING PROFILE
############################
resource "aws_connect_routing_profile" "basic_routing" {
  instance_id = var.connect_instance_id
  name        = "Basic-Routing-Profile"
  description = "Default routing profile"

  default_outbound_queue_id = var.default_queue_id

  media_concurrencies {
    channel     = "VOICE"
    concurrency = 1
  }
}

############################
# AGENT (USER)
############################
resource "aws_connect_user" "agent" {
  instance_id = var.connect_instance_id
  name        = "agent1"
  password    = var.agent_password

  identity_info {
    first_name = "Agent"
    last_name  = "One"
    email      = "agent1@example.com"
  }

  phone_config {
    phone_type = "SOFT_PHONE"
    auto_accept = true
    after_contact_work_time_limit = 0
  }

  routing_profile_id = aws_connect_routing_profile.basic_routing.id
  security_profile_ids = var.security_profile_ids
}
