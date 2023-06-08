# provision-oci-free-kubernetes

source provider-vars.profile
terraform init
terraform apply

cd k0s
k0sctl apply --disable-telemetry --config k0sctl.yaml
k0sctl kubeconfig --disable-telemetry > kubeconfig


https://docs.k0sproject.io/v1.27.1+k0s.0/FAQ/?h=kubeconfig#how-do-i-connect-to-the-cluster