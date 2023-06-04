locals {
  subnet_cidr_block = "10.2.0.0/24"
  # https://docs.k0sproject.io/v1.23.6+k0s.2/networking/?h=netw#required-ports-and-protocols
  additional_default_securty_list_ingress_rules = [
    # TCP 	2380 	etcd peers
    {
      protocol = "6"
      source   = local.subnet_cidr_block
      tcp_options = {
        min = 2380
        max = 2380
      }
    },
    # TCP 	6443 	kube-apiserver
    {
      protocol = "6"
      source   = local.subnet_cidr_block
      tcp_options = {
        min = 6443
        max = 6443
      }
    },
    # TCP 	179 	kube-router
    {
      protocol = "6"
      source   = local.subnet_cidr_block
      tcp_options = {
        min = 179
        max = 179
      }
    },
    # UDP 	4789 	Calico
    {
      protocol = "17"
      source   = local.subnet_cidr_block
      udp_options = {
        min = 4789
        max = 4789
      }
    },
    # TCP 	10250 	kubelet
    {
      protocol = "6"
      source   = local.subnet_cidr_block
      tcp_options = {
        min = 10250
        max = 10250
      }
    },
    # TCP 	9443 	k0s-api
    {
      protocol = "6"
      source   = local.subnet_cidr_block
      tcp_options = {
        min = 9443
        max = 9443
      }
    },
    # TCP 	8132 	konnectivity
    {
      protocol = "6"
      source   = local.subnet_cidr_block
      tcp_options = {
        min = 8132
        max = 8132
      }
    },
  ]
}

module "vcn" {
  source = "./terraform-oci-vcn"

  vcn_name = "k8s-vcn"

  vcn_cidrs               = ["10.2.0.0/16"]
  compartment_id          = var.compartment_id
  create_internet_gateway = true
  #create_nat_gateway = true
  #create_service_gateway = true
  lockdown_default_seclist = false

  additional_default_securty_list_ingress_rules = local.additional_default_securty_list_ingress_rules

  subnets = {
    k8s = { name = "k8s", cidr_block = local.subnet_cidr_block },
  }

  freeform_tags = {
    managed_by    = "terraform"
    module        = "oracle-terraform-modules/vcn/oci"
    "component"   = "vcn"
    "environment" = "pro"
    "part_of"     = "k8s"
  }
}
