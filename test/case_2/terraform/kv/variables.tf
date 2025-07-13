variable "kv_name" {
  type = string
}

variable "kv_sku" {
    type = string
    validation {
      condition = (
        (var.env == "prod" && contains(["Standard","Premium"],var.kv_sku))||
        (var.env != "prod" && var.kv_sku == "Standard")
      )
      error_message = "Only 'standard' is allowed in dev/nonProd. 'standard' or 'premium' are allowed in prod."
    }
}

variable "resource_group_name" {
    type = string
}

variable "location" {
    type = string
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