## Amazon Instance Schedular
- AWS Instance Scheduler is a solution that helps you automate the start and stop schedules of your Amazon Elastic Compute Cloud (EC2) instances. It uses a combination of AWS Lambda functions and Amazon EventBridge (formerly known as CloudWatch Events) to manage your EC2 instance schedules, which can be particularly useful for cost optimization and resource management.
- By using AWS Instance Scheduler, we can effectively manage your EC2 instance schedules, reducing costs by ensuring that instances are running only when needed, and improving resource optimization. This is especially beneficial for environments with variable workloads and non-production instances that are not required 24/7.

## Installation
Dependencies to create the AWS resource using Terraform: 
- Make sure Terraform is installed.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.24.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_function_start_instance"></a> [lambda_function_start_instance](#module\_lambda\_function\_start\_instance) | terraform-aws-modules/lambda/aws | n/a |
| <a name="module_eventbridge_stop_instance"></a> [eventbridge_stop_instance](#module\_eventbridge\_stop\_instance) | terraform-aws-modules/eventbridge/aws | 3.0.0 |
| <a name="module_lambda_function_stop_instance"></a> [lambda_function_stop_instance](#module\_lambda\_function\_stop\_instance) | terraform-aws-modules/lambda/aws | n/a |
| <a name="module_eventbridge_start_instance"></a> [eventbridge_start_instance](#module\_eventbridge\_start\_instance) | terraform-aws-modules/eventbridge/aws | 3.0.0 |        


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | The AWS region where the Lambda function and associated resources will be provisioned. | `string` | `""` | Yes |
| <a name="input_instance_ids"></a> [instance\_ids](#input\_instance\_ids) | Comma-separated list of EC2 instance IDs to be controlled by the Lambda  | `list(string)` | `""` | Yes |
| <a name="input_start_job"></a> [start\_job](#input\_start\_job]) | A schedule expression that determines when the Lambda function will start the specified EC2 instances. For more info, refer https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html | `string` | `""` | Yes |
| <a name="input_stop_job"></a> [stop\_job](#input\_stop\_job) | A schedule expression that determines when the Lambda function will stop the specified EC2 instances For more info, refer https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html | `string` | `""` | Yes |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | The time-zone according to which the lambda will be provisioned | `string` | `""` | Yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name for the infrastructure | `string` | `""` | Yes |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | The stack name name for the stack | `string` | `""` | Yes |


### Usage
Once the Variable and the Module is ready follow the below commands to create the resource
- ```terraform init``` to download the modules
- ```terraform plan``` to generate an execution plan for your infrastructure. 
- ```terraform apply``` to apply the changes and create the infrastructure.
- ```terraform destroy``` to delete the resource which is created through terraform.
