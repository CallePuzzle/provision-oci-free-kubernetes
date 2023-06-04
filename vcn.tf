module "vcn" {
  source  = "./terraform-oci-vcn"

  vcn_name = "k8s-vcn"

  vcn_cidrs               = ["10.2.0.0/16"]
  compartment_id          = var.compartment_id
  create_internet_gateway = true
  #create_nat_gateway = true
  #create_service_gateway = true
  lockdown_default_seclist = false

  subnets = {
    ssh = { name = "ssh", cidr_block = "10.2.0.0/24" },
    k8s = { name = "k8s", cidr_block = "10.2.1.0/24", public = false },
  }

  freeform_tags = {
    managed_by    = "terraform"
    module        = "oracle-terraform-modules/vcn/oci"
    "component"   = "vcn"
    "environment" = "pro"
    "part_of"     = "k8s"
  }
}
