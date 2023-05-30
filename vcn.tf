module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.5.4"

  vcn_name = "k8s-vcn"

  vcn_cidrs               = ["10.2.0.0/16"]
  compartment_id          = var.compartment_id
  create_internet_gateway = true
  #create_nat_gateway = true
  #create_service_gateway = true
  lockdown_default_seclist = false

  subnets = {
    ssh = { name = "ssh", cidr_block = "10.2.0.0/24" }
  }

  freeform_tags = {
    managed_by    = "terraform"
    module        = "oracle-terraform-modules/vcn/oci"
    "component"   = "vcn"
    "environment" = "pro"
    "part_of"     = "k8s"
  }
}
