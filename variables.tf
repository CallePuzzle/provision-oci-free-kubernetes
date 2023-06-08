variable "name" {
  description = "The name of the k0s cluster"
  type        = string
  default    = "k0s"
}

variable "compartment_id" {
  description = "The OCID of the compartment"
  type        = string
}

variable "k0s_config_path" {
  description = "The path to the k0s config file"
  type        = string
}
