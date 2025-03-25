resource "aws_cognito_user_pool" "pool" {
  name = var.user_pool_name
  
  # username_attributes      = ["email"]
  alias_attributes = ["preferred_username"]
  auto_verified_attributes = ["email"]
  
  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }
  
  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject = "Account Verification"
    email_message = "Your verification code is {####}"
  }
  email_configuration {
    reply_to_email_address = var.reply_to_email_address
  }
  
  schema {
    name                = "email"
    attribute_data_type = "String"
    mutable             = true
    required            = true
  }

  device_configuration {
    challenge_required_on_new_device      = true
    device_only_remembered_on_user_prompt = false
  }

  tags = var.default_tags
}

# Sales app client
resource "aws_cognito_user_pool_client" "sales_client" {
  name                = "sales"
  user_pool_id        = aws_cognito_user_pool.pool.id
  
  # generate_secret     = true
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]
}

# Dips app client
resource "aws_cognito_user_pool_client" "dips_client" {
  name                = "dips"
  user_pool_id        = aws_cognito_user_pool.pool.id
  
  # generate_secret     = true
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]
}