variable "environment" {
  description = "The environment name for the infrastructure"
  type        = string
  default     = ""
}

variable "stack_name" {
  description = "The stack name for the stack"
  type        = string
  default     = ""
}

variable "region" {
  default     = ""
  type        = string
  description = "The AWS region where the Lambda function and associated resources will be provisioned"
}

variable "instance_ids" {
  default     = [""]
  type        = list(string)
  description = "Comma-separated list of EC2 instance IDs to be controlled by the Lambda"
}

variable "start_job" {
  default     = ""
  type        = string
  description = "A schedule expression that defines when the Lambda function will start the specified EC2 instances. Use a cron-like format, e.g., cron(0 7 ? * MON-FRI *)"
}

variable "stop_job" {
  default     = ""
  type        = string
  description = "A schedule expression that determines when the Lambda function will stop the specified EC2 instances. Use a cron-like format, e.g., cron(0 18 ? * MON-FRI *)"
}

variable "timezone" {
  default     = ""
  type        = string
  description = "The timezone used for scheduling events in EventBridge. It specifies the time zone in which the schedule expressions will be interpreted"
}


