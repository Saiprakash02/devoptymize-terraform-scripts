## Create IAM user on AWS using Terraform Template

- This Terraform template is designed for creating IAM user on  Amazon Web Services (AWS). To configure IAM user and policies using Terraform.
Create a user
Option to add the user to the existing group
Option to create a custom policy and attach it to the  user
Option to add AWS-managed policies

- The main.tf, variable.tf, provider.tf,output.tf and backend.tf files are typically used in a Terraform project to organize and configure your infrastructure code. 


## Installation
Dependencies to create the AWS resource using Terraform: 
- Make sure Terraform is installed

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.15.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_login_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_login_profile) | resource |
| [aws_iam_user_group_membership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_user_policy](https://registry.terraform.io/providers/rgeraskin/aws3/latest/docs/resources/iam_user_policy) | resource |
| [aws_iam_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_user"></a> [iam\_user](#input\_iam\_user) | the name of the iam user | `string` | `""` | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create the AWS resource. | `string` | `"us-east-1"` | no |
| <a name="password_reset_required"></a> [password\_reset\_required](#input\_password\_reset\_required) | The password_reset_required for the require users to create a new password on first login. | `bool` | `true` | yes |
| <a name="input_existing_group_name"></a> [existing\_group\_name](#input\_existing\_group\_name) | The name of the existing IAM group to add the user to | `list(string)` | `""` | yes |
| <a name="input_custom_policy_name"></a> [custom\_policy\_name](#input\_custom\_policy\_name) | The name of the custom IAM policy to attach to the user | `string` | `""` | no |
| <a name="input_custom_policy_actions"></a> [custom\_policy\_actions](#input\_custom\_policy\_actions) | List of actions for the custom IAM policy. | `list(string)` | `""` | no |
| <a name="input_custom_policy_resources"></a> [custom\_policy\_resources](#input\_custom\_policy\_resources) | List of resources for the custom IAM policy. | `list(string)` | `""` | no |
| <a name="input_apply_custom_policy"></a> [apply\_custom\_policy](#input\_apply\_custom\_policy) | Set to true to apply a custom policy to the IAM user| `bool` | `true` |  |
| <a name="input_apply_managed_policy"></a> [apply\_managed\_policy](#input\_apply\_managed\_policy) | Set to true to apply a managed policy to the IAM user. | `bool` | `false` | no |
| <a name="input_managed_policy_arn"></a> [managed\_policy\_arn](#input\_managed\_policy\_arn) | The ARN of the managed policy to attach to the user | `string` | `""` | no |
| <a name="input_permission_boundary_arn"></a> [permission\_boundary\_arn](#input\_permission\_boundary\_arn) | The ARN of the IAM policy to be used as the permission boundary for the IAM user | `string` | `""` | yes |


### Usage
Once the Variable is ready follow the below commands to create the resource
- ```terraform init``` to download the modules
- ```terraform plan``` to generate an execution plan for your infrastructure. 
- ```terraform apply``` to apply the changes and create the infrastructure.
- ```terraform destroy``` to delete the resource which is created through terraform.
