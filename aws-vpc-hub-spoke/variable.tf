variable "region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "stack_name" {
  description = "the prefix name of all created resources"
  type        = string
  default     = ""
  
}

variable "environment" {
  description = "the name of the environment"
  type = string
  default = ""
}
  
variable "hub_vpc_cidr" {
  description = "CIDR range for the VPC"
  type        = string
  default     = ""  # Updated to a valid CIDR block
}

variable "hub_private_cidrs" {
  description = "List of CIDR ranges for the private subnets"
  type        = list(string)
  default     = null # Updated to valid CIDR blocks
}

variable "hub_public_cidrs" {
  description = "List of CIDR ranges for the public subnets"
  type        = list(string)
  default     = null # Updated to valid CIDR blocks
}

variable "hub_tgw_cidrs" {
  description = "A list of database subnets CIDR inside the VPC"
  type        = list(string)
  default     = null  # Updated to valid CIDR blocks
}

variable "spoke_vpc_a_cidr" {
  description = "CIDR range for the VPC"
  type        = string
  default     = ""  # Updated to a valid CIDR block
}

variable "spoke_private_a_cidrs" {
  description = "List of CIDR ranges for the private subnets"
  type        = list(string)
  default     = null  # Updated to valid CIDR blocks
}

variable "spoke_public_a_cidrs" {
  description = "List of CIDR ranges for the public subnets"
  type        = list(string)
  default     = null  # Updated to valid CIDR blocks
}

variable "spoke_tgw_a_cidrs" {
  description = "A list of database subnets CIDR inside the VPC"
  type        = list(string)
  default     = null  # Updated to valid CIDR blocks
}

variable "spoke_vpc_b_cidr" {
  description = "CIDR range for the VPC"
  type        = string
  default     = ""  # Updated to a valid CIDR block
}

variable "spoke_private_b_cidrs" {
  description = "List of CIDR ranges for the private subnets"
  type        = list(string)
  default     = null  # Updated to valid CIDR blocks
}

variable "spoke_public_b_cidrs" {
  description = "List of CIDR ranges for the private subnets"
  type        = list(string)
  default     = null  # Updated to valid CIDR blocks
}

variable "spoke_tgw_b_cidrs" {
  description = "A list of database subnets CIDR inside the VPC"
  type        = list(string)
  default     = null  # Updated to valid CIDR blocks
}
