variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "Lambda function nnakme"
  type        = string
  default     = "my-simple-lambdas"
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