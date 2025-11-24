
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# --------------------------------------
# IAM Role for Lambda
# --------------------------------------
resource "aws_iam_role" "lambda_role" {
  name = "${var.lambda_function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Environment = var.environment
  }
}

# Attach basic execution policy
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

# --------------------------------------
# Lambda Function (ZIP created in CI/CD)
# --------------------------------------
resource "aws_lambda_function" "main" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_role.arn

  # ZIP created by GitHub Actions and placed in terraform folder before apply
  filename         = "${path.module}/lambda_function.zip"

  # hash ensures updates trigger new deployment
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  #handler         = "index.handler"          # Node.js
  handler          = "index.lambda_handler"   # Python

  runtime          = "python3.11"
  timeout          = 30
  memory_size      = 128

  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# --------------------------------------
# CloudWatch Log Group
# --------------------------------------
resource "aws_cloudwatch_log_group" "lambda_logs1" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 7

  tags = {
    Environment = var.environment
  }
}
