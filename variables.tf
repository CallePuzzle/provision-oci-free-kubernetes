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

variable "enable_argocd_apps" {
  description = "Enable ArgoCD apps"
  type        = bool
  default     = true
}

variable "enable_nginx_as_argocd_app" {
  description = "Enable nginx as ArgoCD app"
  type        = bool
  default     = true
}

variable "manifests_source" {
  description = "A yaml object with source variables for ArgoCD application manifests"
  type = object({
    repoURL        = string
    targetRevision = string
    path           = string
    directory = optional(object({
      recurse = optional(bool)
      exclude = optional(string)
      include = optional(string)
    }))
  })
  default = null
}