######################### Network ##############################

variable "environment" {
  description = "the name of the environment"
  type        = string
  default     = ""
}

variable "stack_name" {
  description = "the name of the stack"
  type        = string
  default     = ""
}

variable "region" {
  description = "the region in which to deploy resources"
  type        = string
  default     = ""
}


variable "vpc_cidr_range" {
  description = "The CIDR range for your VPC"
  type        = string
  default     = ""
}

variable "public_subnets" {
  description = "A list of public subnets CIDR inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets CIDR inside the VPC"
  type        = list(string)
  default     = []
}


################################# S3 CDN WAF R53 ############################################


variable "cdn_aliases" {
  description = "The aliases name"
  type        = list(string)
  default = []  
}

variable "acm_certificate_arn" {
  description = "ARN of the certificate"
  type = string
  default = ""
}



variable "hosted_zone_id" {
  description = "The id of the route53 zone"
  type = string
  default = ""
}






