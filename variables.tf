variable "name" {
  description = "The name of the k0s cluster"
  type        = string
  default     = "k0s"
}

variable "compartment_id" {
  description = "The OCID of the compartment"
  type        = string
}

variable "k0s_config_path" {
  description = "The path to the k0s config file"
  type        = string
}

variable "enable_argocd" {
  description = "Enable ArgoCD"
  type        = bool
  default     = true
}

variable "enable_nginx" {
  description = "Enable nginx"
  type        = bool
  default     = true
}

variable "enable_argocd_apps" {
  description = "Enable ArgoCD apps"
  type        = bool
  default     = true
}

variable "argocd_host" {
  description = "The hostname of the ArgoCD server"
  type        = string
  default     = null
}

variable "manifests_source" {
  description = "A yaml object with source variables for ArgoCD application manifests"
  type = object({
    repo_url          = string
    target_revision   = string
    path              = string
    directory_recurse = optional(bool, false)
  })
  default = null
}

variable "additional_k0s_config" {
  description = "A yaml object with additional k0s config"
  default     = {}
}