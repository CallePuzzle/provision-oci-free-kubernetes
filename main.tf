locals {
  argocd_values = var.argocd_values != {} ? var.argocd_values : templatefile("${path.module}/templates/argocd-values.yaml.tmpl", {
    argocd_host = var.argocd_host
  })
}

resource "local_file" "k0sctl" {
  filename = var.k0s_config_path
  content  = templatefile("${path.module}/templates/k0sctl.yaml.tmpl", {
    private_ip         = module.instance["controllerworker"].private_ip[0]
    public_ip          = module.instance["controllerworker"].public_ip[0]
    k0s_version        = var.k0s_version
    manifests_source   = var.manifests_source
    enable_argocd      = var.enable_argocd
    enable_argocd_apps = var.enable_argocd_apps
    enable_nginx       = var.enable_nginx
    argocd_values      = <<EOF
${local.argocd_values}
EOF
  })
}