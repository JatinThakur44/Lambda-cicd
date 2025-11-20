variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
  default     = "my-simple-lambda"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
/*
variable "access_key"{
  description = "access key"
  type        = string
}

variable "secret_key"{
  description = "secret key"
  type        = string
}*/