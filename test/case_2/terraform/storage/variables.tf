variable "storage_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string  
}

variable "access_tier" {
   type = string 
}

variable "account_kind" {
    type = string
}

variable "account_replication_type" {
    type = string
}

variable "account_tier" {
    type = string
        validation {
      condition = (
        (var.env == "prod" && contains(["Standard","Premium"],var.account_tier))||
        (var.env != "prod" && var.account_tier == "Standard")
      )
      error_message = "Only 'standard' is allowed in dev/nonProd. 'standard' or 'premium' are allowed in prod."
    }
}

variable "subnet_id" {
     type = string 
}

variable "la_workspace_id" {
     type = string 
}

variable "env" {
  type = string
}