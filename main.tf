provider "oci" {
}

module "oci-k0s" {
  source = "./terraform-module"

  compartment_id = "ocid1.tenancy.oc1..aaaaaaaa5ii3uidynoqhjub5ub66fm3ryn2my6txw6xrguihckyr2uyarlkq"
}