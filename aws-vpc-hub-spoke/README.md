## Amazon VPC - Hub and spoke using terraform template
- This Terraform scripts are used to create various AWS resources, including a hub vpc and spoke vpcs.
- The main.tf, variable.tf, provider.tf, and backend.tf files are typically used in a Terraform project to organize and configure your infrastructure code.

## Installation
Dependencies to create the AWS resource using Terraform: 
- Make sure Terraform is installed.


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.25.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_hub-vpc"></a> [hub-vpc](#module\_hub-vpc) | terraform-aws-modules/vpc/aws | 5.1.1 |
| <a name="module_spoke-vpc-A"></a> [spoke-vpc-A](#module\_spoke-vpc-A) | terraform-aws-modules/vpc/aws | 5.1.1 |    
| <a name="module_spoke-vpc-B"></a> [spoke-vpc-B](#module\_spoke-vpc-B) | terraform-aws-modules/vpc/aws | 5.1.1 |    

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway) | resource |
| [aws_ec2_transit_gateway_route.tgw_hub_vpc_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.tgw_spoke1_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.tgw_spoke2_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route_table.hub_vpc_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table.spoke1_vpc_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table.spoke2_vpc_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table_association.association_hub_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_association.association_spoke1_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_association.association_spoke2_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.propagation1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.propagation2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.propagation_spoke1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.propagation_spoke2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.hub_vpc_att](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.tgw_attach_spoke1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.tgw_attach_spoke2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_route.hub_route_private1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.hub_route_private1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.hub_route_private2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.hub_route_private2a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.spoke1_route_private1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.spoke1_route_private2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.spoke2_route_private1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.spoke2_route_private2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | the name of the environment | `string` | `"dev"` | no |
| <a name="input_hub_private_cidrs"></a> [hub\_private\_cidrs](#input\_hub\_private\_cidrs) | List of CIDR ranges for the private subnets | `list(string)` | `null` | no |
| <a name="input_hub_public_cidrs"></a> [hub\_public\_cidrs](#input\_hub\_public\_cidrs) | List of CIDR ranges for the public subnets | `list(string)` | `null` | no |
| <a name="input_hub_tgw_cidrs"></a> [hub\_tgw\_cidrs](#input\_hub\_tgw\_cidrs) | A list of database subnets CIDR inside the VPC | `list(string)` | `null` | no |
| <a name="input_hub_vpc_cidr"></a> [hub\_vpc\_cidr](#input\_hub\_vpc\_cidr) | CIDR range for the VPC | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_spoke_private_A_cidrs"></a> [spoke\_private\_A\_cidrs](#input\_spoke\_private\_A\_cidrs) | List of CIDR ranges for the private subnets | `list(string)` | `null` | no |
| <a name="input_spoke_private_B_cidrs"></a> [spoke\_private\_B\_cidrs](#input\_spoke\_private\_B\_cidrs) | List of CIDR ranges for the private subnets | `list(string)` |`null` | no |
| <a name="input_spoke_public_A_cidrs"></a> [spoke\_public\_A\_cidrs](#input\_spoke\_public\_A\_cidrs) | List of CIDR ranges for the public subnets | `list(string)` | `null` | no |    
| <a name="input_spoke_public_B_cidrs"></a> [spoke\_public\_B\_cidrs](#input\_spoke\_public\_B\_cidrs) | List of CIDR ranges for the private subnets | `list(string)` | `null` | no |   
| <a name="input_spoke_tgw_A_cidrs"></a> [spoke\_tgw\_A\_cidrs](#input\_spoke\_tgw\_A\_cidrs) | A list of database subnets CIDR inside the VPC | `list(string)` | `null` | no |
| <a name="input_spoke_tgw_B_cidrs"></a> [spoke\_tgw\_B\_cidrs](#input\_spoke\_tgw\_B\_cidrs) | A list of database subnets CIDR inside the VPC | `list(string)` | `null` | no |
| <a name="input_spoke_vpc_A_cidr"></a> [spoke\_vpc\_A\_cidr](#input\_spoke\_vpc\_A\_cidr) | CIDR range for the VPC | `string` | `""` | no |
| <a name="input_spoke_vpc_B_cidr"></a> [spoke\_vpc\_B\_cidr](#input\_spoke\_vpc\_B\_cidr) | CIDR range for the VPC | `string` | `""` | no |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | the prefix name of all created resources | `string` | `""` | no |

### Usage
Once the Variable and the Module is ready follow the below commands to create the resource
- ```terraform init``` to download the modules
- ```terraform plan``` to generate an execution plan for your infrastructure. 
- ```terraform apply``` to apply the changes and create the infrastructure.
- ```terraform destroy``` to delete the resource which is created through terraform.


