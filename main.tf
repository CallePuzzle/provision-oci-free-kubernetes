data "oci_core_images" "this" {
  for_each = local.instances

  compartment_id           = var.compartment_id
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "22.04"
  shape                    = each.value.shape
}

locals {
  instances = {
    master = {
      instance_count              = 2
      instance_display_name       = "k8s-master"
      shape                       = "VM.Standard.E2.1.Micro"
      instance_flex_memory_in_gbs = null
      instance_flex_ocpus         = null
    }
    worker = {
      instance_count              = 1
      instance_display_name       = "k8s-worker"
      shape                       = "VM.Standard.A1.Flex"
      instance_flex_memory_in_gbs = 24
      instance_flex_ocpus         = 4
    }
  }
}

module "instance" {
  source = "oracle-terraform-modules/compute-instance/oci"

  for_each = local.instances

  compartment_ocid            = var.compartment_id
  ad_number                   = 1
  instance_count              = each.value.instance_count
  instance_display_name       = each.value.instance_display_name
  instance_state              = "RUNNING"
  shape                       = each.value.shape
  source_ocid                 = data.oci_core_images.this[each.key].images.0.id
  source_type                 = "image"
  instance_flex_memory_in_gbs = each.value.instance_flex_memory_in_gbs
  instance_flex_ocpus         = each.value.instance_flex_ocpus
  baseline_ocpu_utilization   = "BASELINE_1_1"
  cloud_agent_plugins = {
    java_management_service = "DISABLED"
    autonomous_linux        = "ENABLED"
    bastion                 = "DISABLED"
    vulnerability_scanning  = "ENABLED"
    osms                    = "ENABLED"
    management              = "DISABLED"
    custom_logs             = "ENABLED"
    run_command             = "ENABLED"
    monitoring              = "ENABLED"
    block_volume_mgmt       = "DISABLED"
  }
  # operating system parameters
  ssh_public_keys = file("~/.ssh/id_rsa.pub")
  # networking parameters
  public_ip    = "EPHEMERAL"
  subnet_ocids = [module.vcn.subnet_id["k8s"]]

  freeform_tags = {
    managed_by    = "terraform"
    module        = "oracle-terraform-modules/compute-instance/oci"
    "component"   = "instance"
    "environment" = "pro"
    "part_of"     = "k8s"
  }
}


resource "local_file" "k0sctl" {
  filename = "${path.module}/k0s/k0sctl.yaml"
  content = templatefile("${path.module}/k0s/k0sctl.yaml.tmpl", {
    master_1_private_ip = module.instance["master"].private_ip[0]
    master_1_public_ip  = module.instance["master"].public_ip[0]
    master_2_private_ip = module.instance["master"].private_ip[1]
    master_2_public_ip  = module.instance["master"].public_ip[1]
    worker_private_ip   = module.instance["worker"].private_ip[0]
    worker_public_ip    = module.instance["worker"].public_ip[0]
  })
}