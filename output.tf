
# Saída url api gateway
output "deployment_invoke_url" {
  description = "Api GW Deployment invoke url"
  value       = aws_api_gateway_deployment.deployment.invoke_url
}

# saida queue url
output "queue_url" {
  value = aws_sqs_queue.rob_sqs.url
}

output "cognito_user_pool_id" {
  value       = aws_cognito_user_pool.pool.id
  description = "ID do Cognito User Pool"
}

output "cognito_client_id" {
  value       = aws_cognito_user_pool_client.client.id
  description = "ID do Cognito User Pool Client"
}

output "cognito_token_command" {
  value       = format("aws cognito-idp admin-initiate-auth --user-pool-id %s --client-id %s --auth-flow ADMIN_NO_SRP_AUTH --auth-parameters USERNAME=user_rob_cognito,PASSWORD=w3ak-p455w0Wd", aws_cognito_user_pool.pool.id,aws_cognito_user_pool_client.client.id)
  description = "Combined information of Cognito User Pool ID and Cognito Client ID"
}