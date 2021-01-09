resource "aws_apigatewayv2_api" "http-api-gateway" {
  name          = var.http_api_gateway_name
  description   = var.http_api_gateway_description
  protocol_type = "HTTP"
}