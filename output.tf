data "aws_lambda_function" "stop_lambda_function" {
  function_name = var.function_names[0]
  depends_on = [
    aws_lambda_function.create_lambda_functions
  ]
}

data "aws_lambda_function" "start_lambda_function" {
  function_name = var.function_names[1]
  depends_on = [
    aws_lambda_function.create_lambda_functions
  ]
}

data "archive_file" "python_lambda_package_start" {
  for_each    = var.archive_to_zip
  source_file = each.key
  output_path = each.value
  type        = "zip"
}

output "START_ARN" {
  value = data.aws_lambda_function.stop_lambda_function.arn
}

output "STOP_ARN" {
  value = data.aws_lambda_function.start_lambda_function.arn
}
