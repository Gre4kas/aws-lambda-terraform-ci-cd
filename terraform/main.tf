resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "terraform_lambda_func" {
  function_name = "Spacelift_Test_Lambda_Function"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.8"
  handler       = "index.lambda_handler"
  filename      = "${path.module}/../app/hello-python.zip"
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/hello_world_lambda"
  retention_in_days = 14
}