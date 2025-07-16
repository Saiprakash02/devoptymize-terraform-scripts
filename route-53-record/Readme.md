## Route53_record on AWS using Terraform Template

- This Terraform template is designed for creating and managing Route 53 records on Amazon Web Services (AWS). AWS Route 53 is a scalable and highly available Domain Name System (DNS) web service that allows you to route traffic to various AWS resources based on DNS records.
- The main.tf, variable.tf, provider.tf, and backend.tf files are typically used in a Terraform project to organize and configure your infrastructure code. 


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
| [aws_route53_record.devoptymize](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias_name"></a> [alias\_name](#input\_alias\_name) | the name of the alias | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create Route 53 records in. | `string` | `"us-east-1"` | no |
| <a name="input_collection_id"></a> [collection\_id](#input\_collection\_id) | The collection ID for the CIDR routing policy. | `string` | `""` | no |
| <a name="input_continent"></a> [continent](#input\_continent) | Continent for geolocation routing (e.g., NA, EU) | `string` | `""` | no |
| <a name="input_enable_alias"></a> [enable\_alias](#input\_enable\_alias) | Whether to use alias for the Route 53 record | `bool` | `null` | no |
| <a name="input_enable_target_health"></a> [enable\_target\_health](#input\_enable\_target\_health) | Set to true to enable target health evaluation. | `bool` | `true` | no |
| <a name="input_location_name"></a> [location\_name](#input\_location\_name) | The location name for the CIDR routing policy. | `string` | `""` | no |
| <a name="input_record_name"></a> [record\_name](#input\_record\_name) | The name of the DNS record. | `string` | `""` | no |
| <a name="input_record_type"></a> [record\_type](#input\_record\_type) | The type of DNS record (e.g., A, CNAME, MX, etc.). | `string` | `""` | no |
| <a name="input_routing_policy"></a> [routing\_policy](#input\_routing\_policy) | Select the routing policy type: simple, weighted, geolocation, or ip-based | `string` | `""` | no |
| <a name="input_set_identifier"></a> [set\_identifier](#input\_set\_identifier) | Identifier for the routing record set | `string` | `""` | no |
| <a name="input_target_hosted_zone_id"></a> [target\_hosted\_zone\_id](#input\_target\_hosted\_zone\_id) | Target hosted zone id | `string` | `""` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | The Time-to-Live (TTL) value for the DNS record. | `number` | `null` | no | 
| <a name="input_value"></a> [value](#input\_value) | The value of the DNS record. | `list(string)` | <pre>[""]</pre> | no |
| <a name="input_weight"></a> [weight](#input\_weight) | Weight for weighted routing policy | `number` | `null` | no |      
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Zone ID for Route 53 alias records | `string` | `""` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | The name of the Route 53 hosted zone. | `string` | `""` | no |

### Usage
Once the Variable and the Module is ready follow the below commands to create the resource
- ```terraform init``` to download the modules
- ```terraform plan``` to generate an execution plan for your infrastructure. 
- ```terraform apply``` to apply the changes and create the infrastructure.
- ```terraform destroy``` to delete the resource which is created through terraform.
