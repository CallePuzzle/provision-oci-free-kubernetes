variable "name" {
  description = "The name of the k0s cluster"
  type        = string
  default    = "k0s"
}

variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The list of subnet OCIDs"
}

variable "backend_ip_address" {
  type        = string
  description = "The IP address of the backend"
}