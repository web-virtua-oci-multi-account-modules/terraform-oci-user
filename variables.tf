variable "name" {
  description = "Group name"
  type        = string
}

variable "description" {
  description = "Description to group is required"
  type        = string
}

variable "compartment_id" {
  description = "Compartment ID"
  type        = string
  default     = null
}

variable "email" {
  description = "Email to user optional"
  type        = string
  default     = null
}

variable "user_groups_ids" {
  description = "List with OCID of groups to attach in user"
  type        = list(string)
  default     = []
}

variable "use_tags_default" {
  description = "If true will be use the tags default to resources"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to group"
  type        = map(any)
  default     = {}
}

variable "defined_tags" {
  description = "Defined tags to group"
  type        = map(any)
  default     = null
}

variable "policies" {
  description = "List of policies to be created"
  type = list(object({
    name           = string
    compartment_id = string
    description    = string
    statements     = list(string)
    version_date   = optional(string)
    defined_tags   = optional(map(any))
    freeform_tags  = optional(map(any))
  }))
  default = []
}
