locals {
  k0s_config_content = yamldecode(templatefile("${path.module}/k0sctl.yaml.tmpl", {
    private_ip         = module.instance["controllerworker"].private_ip[0]
    public_ip          = module.instance["controllerworker"].public_ip[0]
    manifests_source   = var.manifests_source
    enable_argocd      = var.enable_argocd
    enable_argocd_apps = var.enable_argocd_apps
    enable_nginx       = var.enable_nginx
    argocd_host        = var.argocd_host
  }))
}

module "k0s_deepmerge" {
  source = "Invicton-Labs/deepmerge/null"
  maps = [
    local.k0s_config_content,
    var.additional_k0s_config
  ]
}

resource "local_file" "k0sctl" {
  filename = var.k0s_config_path
  content  = yamlencode(module.k0s_deepmerge.merged)
}