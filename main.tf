resource "aws_lambda_function" "html_lambda" {
  filename         = "lambda_function.zip"
  function_name    = "myLambdaFunction"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_function"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.rob_sqs.url
    }
  }
}
resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.html_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*/*"
}

# Define a new policy document that allows sending messages to the SQS queue
data "aws_iam_policy_document" "lambda_sqs_policy" {
  statement {
    actions = ["sqs:SendMessage"]

    resources = [
      aws_sqs_queue.rob_sqs.arn
    ]

    effect = "Allow"
  }
}

# Attach the policy to the Lambda role
resource "aws_iam_role_policy" "lambda_sqs_policy" {
  name   = "lambda-sqs-policy"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_sqs_policy.json
}


data "archive_file" "lambda_package" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function.zip"
}

# ======= Lambda Role to SQS =======


######## =======================   =======================

# data "aws_iam_policy" "lambda_basic_execution_role_policy" {
#   name = "AWSLambdaBasicExecutionRole"
# }


# resource "aws_iam_role" "lambda_iam_role" {
#   name_prefix = "LambdaSQSRole-"
#   managed_policy_arns = [
#     data.aws_iam_policy.lambda_basic_execution_role_policy.arn,
#     aws_iam_policy.lambda_policy.arn
#   ]

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "lambda.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
# }

# data "aws_iam_policy_document" "lambda_policy_document" {
#   statement {

#     effect = "Allow"

#     actions = [
#       "sqs:SendMessage*"
#     ]

#     resources = [
#       aws_sqs_queue.rob_sqs.arn
#       #   aws_sqs_queue.sqs_queue.arn
#     ]
#   }
# }

# resource "aws_iam_policy" "lambda_policy" {
#   name_prefix = "lambda_policy"
#   path        = "/"
#   policy      = data.aws_iam_policy_document.lambda_policy_document.json
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# output "QueuePublisherFunction" {
#   value       = aws_lambda_function.html_lambda.arn
#   description = "QueuePublisherFunction function name"
# }

# output "SQSqueueARN" {
#   value       = aws_sqs_queue.rob_sqs.arn
#   description = "SQS queue ARN"
# }

# output "SQSqueueURL" {
#   value       = aws_sqs_queue.rob_sqs.url
#   description = "SQS queue URL"
# }
