variable "vm_name" {
  type = string
}

variable "resource_group_name" {
  type = string  
}

variable "location" {
   type = string 
}

variable "vm_size" {
    type = string
}

variable "storage_account_type" {
    type = string
}

variable "admin_username" {
    type = string
}

variable "admin_password" {
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