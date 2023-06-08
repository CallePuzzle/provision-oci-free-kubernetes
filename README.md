# Terraform Module to install K0s on Oracle Cloud Infrastructure

This module installs a K0s cluster on Oracle Cloud Infrastructure, using only free tier resources.

## Prerequisites

- Terraform v1.4.6 or higher
- k0sctl v0.15.1 or higher
- An account with Oracle Cloud Infrastructure

## Usage

Get required variables from OCI: [https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm)

```bash
$ cat provider-vars.profile
export TF_VAR_tenancy_ocid=xxxx
export TF_VAR_user_ocid=xxxxx
export TF_VAR_fingerprint=xxxx
export TF_VAR_private_key_path=./private_key.pem
export TF_VAR_region=eu-marseille-1
```

Configure the module, see an example in [test/main.tf](test/main.tf)

```terraform
provider "oci" {
}

module "oci-k0s" {
  source = "../"

  compartment_id  = "ocid1.tenancy.oc1..aaaaaaaa5ii3uidynoqhjub5ub66fm3ryn2my6txw6xrguihckyr2uyarlkq"
  k0s_config_path = "${path.root}/k0sctl.yaml"
}
```

```bash
source provider-vars.profile
terraform init
terraform apply
k0sctl apply --disable-telemetry --config k0sctl.yaml
k0sctl kubeconfig --disable-telemetry > kubeconfig
```

https://docs.k0sproject.io/v1.27.1+k0s.0/FAQ/?h=kubeconfig#how-do-i-connect-to-the-cluster