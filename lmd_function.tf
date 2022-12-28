
resource "aws_lambda_function" "create_lambda_functions" {
  for_each      = var.lambda_function
  function_name = each.key
  filename      = each.value
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.9"
  handler       = "lambda_function.lambda_handler"
  timeout       = 10
  environment {
    variables = {
      name_ID   = "${var.tag_name}"
      values_ID = "${var.tag_value}"
      region    = "${var.region}"
    }
  }
}

resource "aws_lambda_permission" "allow_aws_lambda_permission" {
  count         = length(var.function_names)
  function_name = var.function_names[count.index]
  statement_id  = "AllowExecutionFromEventbridge_stop_ec2"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
}
