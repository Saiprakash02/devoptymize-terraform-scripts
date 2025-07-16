#Lambda function for starting Instance
module "lambda_function_start_instance" {
  source        = "terraform-aws-modules/lambda/aws"
  function_name = "${var.environment}-${var.stack_name}-StartLambdaFunction"
  description   = "Lambda function for Starting the EC2 Instance"
  environment_variables = {
    instances = join(",", var.instance_ids) # Convert the list to a comma-separated string
    Region    = var.region
  }
  handler            = "lambda_function.lambda_handler"
  runtime            = "python3.8"
  publish            = true
  source_path        = "./lambda_function.py"
  role_name          = "${var.environment}-${var.stack_name}-StartLambdaFunctionRole"
  attach_policy      = true
  policy             = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  attach_policy_json = true

  policy_json = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Action"   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
        "Effect"   = "Allow",
        "Resource" = "*"
      },
      {
        "Action" = [
          "ec2:StartInstances",
          "ec2:StopInstances"
        ],
        "Effect"   = "Allow",
        "Resource" = "*"
      }
    ]
  })
  allowed_triggers = {
    ScheduledEventBridgeRule = {
      principal  = "events.amazonaws.com"
      source_arn = module.eventbridge_start_instance.eventbridge_schedule_arns["${var.environment}-${var.stack_name}-StartSchedular"]
    }
  }
}

#Eventbridge for starting Instance
module "eventbridge_start_instance" {
  source  = "terraform-aws-modules/eventbridge/aws"
  version = "3.0.0"

  create_bus = false
  schedules = {
    "${var.environment}-${var.stack_name}-StartSchedular" = {
      description         = "Trigger for a Lambda which starts the Instance"
      schedule_expression = var.start_job
      timezone            = var.timezone
      arn                 = module.lambda_function_start_instance.lambda_function_arn
    }
  }
  targets = {
    "${var.environment}-${var.stack_name}-StartSchedular" = [
      {
        name = "lambda-starting-Instance-cron-task"
        arn  = module.lambda_function_start_instance.lambda_function_arn
      }
    ]
  }
  role_name          = "${var.environment}-${var.stack_name}-StartschedularRole"
  attach_policy_json = true
  policy_json = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Action"   = "lambda:InvokeFunction",
        "Effect"   = "Allow",
        "Resource" = "${module.lambda_function_start_instance.lambda_function_arn}"
      }
    ]
  })

  tags = {
    Pattern = "terraform-eventbridge-start-Instance-scheduled-lambda"
    Module  = "eventbridge"
  }
}



#lambda function for stopping the Instance

module "lambda_function_stop_instance" {
  source        = "terraform-aws-modules/lambda/aws"
  function_name = "${var.environment}-${var.stack_name}-StopLambdaFunction"
  description   = "Lambda function for Stoping the EC2 Instance"
  environment_variables = {
    instances = join(",", var.instance_ids) # Convert the list to a comma-separated string
    Region    = var.region
  }
  handler            = "lambda_function.lambda_handler2"
  runtime            = "python3.8"
  publish            = true
  source_path        = "./lambda_function.py"
  role_name          = "${var.environment}-${var.stack_name}-StopLambdaFunctionRole"
  attach_policy      = true
  policy             = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  attach_policy_json = true

  policy_json = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Action"   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
        "Effect"   = "Allow",
        "Resource" = "*"
      },
      {
        "Action" = [
          "ec2:StartInstances",
          "ec2:StopInstances"
        ],
        "Effect"   = "Allow",
        "Resource" = "*"
      }
    ]
  })
  allowed_triggers = {
    ScheduledEventBridgeRule = {
      principal  = "events.amazonaws.com"
      source_arn = module.eventbridge_stop_instance.eventbridge_schedule_arns["${var.environment}-${var.stack_name}-StopSchedular"]
    }
  }
}

#Eventbridge for stopping the Instance
module "eventbridge_stop_instance" {
  source  = "terraform-aws-modules/eventbridge/aws"
  version = "3.0.0"

  create_bus = false
  schedules = {
    "${var.environment}-${var.stack_name}-StopSchedular" = {
      description         = "Trigger for a Lambda which stops the Ec2"
      schedule_expression = var.stop_job
      timezone            = var.timezone
      arn                 = module.lambda_function_stop_instance.lambda_function_arn
    }
  }
  targets = {
    "${var.environment}-${var.stack_name}-StopSchedular" = [
      {
        name = "lambda-stopping-cron-task"
        arn  = module.lambda_function_stop_instance.lambda_function_arn
      }
    ]
  }
  attach_policy_json = true
  role_name          = "${var.environment}-${var.stack_name}-StopschedularRole"
  policy_json = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Action"   = "lambda:InvokeFunction",
        "Effect"   = "Allow",
        "Resource" = "${module.lambda_function_stop_instance.lambda_function_arn}"
      }
    ]
  })

  tags = {
    Pattern = "terraform-eventbridge-Stop-Instance-scheduled-lambda"
    Module  = "eventbridge"
  }
}
