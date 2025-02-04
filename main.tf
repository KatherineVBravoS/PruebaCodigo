provider "aws" {
  region = "us-east-1"
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# S3 Bucket for Lambda code
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "lambda-bucket23"
  force_destroy = true
}

# Upload the Lambda zip to S3
resource "aws_s3_object" "lambda_zip" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = "lambda.zip"
  source = "lambda.zip"
}

# Lambda Function
resource "aws_lambda_function" "my_lambda" {
  function_name    = "mi-funcion-lambda"
  role            = aws_iam_role.lambda_role.arn
  handler         = "lambda_function.lambda_handler"  # Asegúrate de que coincida con tu código JS
  runtime         = "python3.9"

  s3_bucket       = aws_s3_bucket.lambda_bucket.bucket
  s3_key          = aws_s3_object.lambda_zip.key

  environment {
    variables = {
      API_URL = "https://dn8mlk7hdujby.cloudfront.net/interview/insurance/58"
    }
  }
}
