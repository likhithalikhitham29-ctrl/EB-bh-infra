output "contact_flow_id" {
  value = aws_connect_contact_flow.basic_flow.id
}

output "agent_username" {
  value = aws_connect_user.agent.name
}
