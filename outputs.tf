output "lambda_function_name" {
  description = "Nombre de la función Lambda creada"
  value       = aws_lambda_function.my_lambda.function_name
}

output "lambda_invoke_arn" {
  description = "ARN para invocar la función Lambda"
  value       = aws_lambda_function.my_lambda.invoke_arn
}

output "s3_bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.lambda_bucket.id
}
