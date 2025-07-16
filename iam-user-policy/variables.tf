variable "iam_user" {
  description = "the name of the iam user"
  type        = string
  default     = ""
}

variable "region" {
  description = "the name of the region"
  type        = string
  default     = ""
}


variable "password_reset_required" {
  description = "Do you want to require users to create a new password on first login?"
  type        = bool
  default     = true
}

variable "existing_group_name" {
  description = "The name of the existing IAM group to add the user to."
  type        = list(string)
  default     = []
}


variable "custom_policy_name" {
  type        = string
  description = "The name of the custom IAM policy to attach to the user"
  default     = ""
}

variable "custom_policy_actions" {
  type        = list(string)
  description = "List of actions for the custom IAM policy"
  default     = []
}

variable "custom_policy_resources" {
  type        = list(string)
  description = "List of resources for the custom IAM policy"
  default     = []
}

variable "apply_custom_policy" {
  type        = bool
  description = "Set to true to apply a custom policy to the IAM user"
  default     = null
}

variable "apply_managed_policy" {
  type        = bool
  description = "Set to true to apply a managed policy to the IAM user"
  default     = null
}

variable "managed_policy_arn" {
  type        = string
  description = "The ARN of the managed policy to attach to the user"
  default     = ""
}

variable "permission_boundary_arn" {
  description = "The ARN of the IAM policy to be used as the permission boundary for the IAM user."
  type        = string
  default     = ""  
}
