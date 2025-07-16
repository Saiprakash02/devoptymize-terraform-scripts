variable "region" {
  description = "The AWS region to create Route 53 records in."
  type        = string
  default     = "" # Change to your desired region
}

variable "zone_name" {
  description = "The name of the Route 53 hosted zone."
  type        = string
  default = ""
}

variable "zone_id" {
  description = "Zone ID for Route 53 alias records"
  type        = string
  default = ""
}

variable "record_name" {
  description = "The name of the DNS record."
  type        = string
  default = ""
}

variable "record_type" {
  description = "The type of DNS record (e.g., A, CNAME, MX, etc.)."
  type        = string
  default = ""
}

variable "enable_alias" {
  description = "Whether to use alias for the Route 53 record"
  type        = bool
  default = null
}

variable "ttl" {
  description = "The Time-to-Live (TTL) value for the DNS record."
  type        = string
  default     = null
}

variable "value" {
  description = "The value of the DNS record."
  type        = list(string)
  default =  null
}

variable "routing_policy" {
  description = "Select the routing policy type: simple, weighted, geolocation, or ip-based"
  type        = string
  default     = "" 
}

variable "alias_name" {
  description = "the name of the alias"
  type = string
  default = ""
  
}
variable "target_hosted_zone_id" {
  description = "Target hosted zone id"
  type        = string
  default     = ""  
}

variable "enable_target_health" {
  description = "Set to true to enable target health evaluation."
  type        = bool
  default = null
}


variable "weight" {
  description = "Weight for weighted routing policy"
  type        = string
  default     = null 
}

variable "set_identifier" {
  description = "Identifier for the routing record set"
  type        = string
  default     = ""  
}

variable "continent" {
  description = "Continent for geolocation routing (e.g., NA, EU)"
  type        = string
  default     = "" 
}

variable "collection_id" {
  description = "The collection ID for the CIDR routing policy."
  type        = string
  default     = "" # You can change the default value
}

variable "location_name" {
  description = "The location name for the CIDR routing policy."
  type        = string
  default     = "" # You can change the default value
}
