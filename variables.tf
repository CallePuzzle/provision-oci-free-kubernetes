variable "name" {
  description = "The name of the k0s cluster"
  type        = string
  default     = "k0s"
}

variable "compartment_id" {
  description = "The OCID of the compartment"
  type        = string
}

variable "source_ocid" {
  description = "The OCID of the source image"
  type        = string
  default     = null
}

variable "k0s_config_path" {
  description = "The path to the k0s config file"
  type        = string
}

variable "k0s_version" {
  description = "The version of k0s to install"
  type        = string
  default     = "1.27.4+k0s.0"
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

variable "projects" {
  description = "ArgoCD projects"
  type = list(object({
    name = string
    source = object({
      repo_url        = string
      target_revision = string
      path            = optional(string, ".")
      plugin          = optional(string, "")
    })
    destination_namespace = string
    auto_sync             = optional(bool, true)
  }))
  default = []
}


variable "argocd_values" {
  description = "Replace the default ArgoCD values.yaml with this yaml object"
  default     = {}
}