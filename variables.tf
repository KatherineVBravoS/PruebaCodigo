variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "Nombre de la función Lambda"
  type        = string
  default     = "mi-funcion-lambda"
}

variable "s3_bucket_name" {
  description = "Nombre del bucket de S3 donde se subirá el código"
  type        = string
  default     = "lambda-bucket23"
}
