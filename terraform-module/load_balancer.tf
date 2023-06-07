module "lb" {
  source = "./lb"

  compartment_id = var.compartment_id
  subnet_ids     = [module.vcn.subnet_id["k8s"]]

  backend_ip_address = module.instance["worker"].private_ip[0]
}