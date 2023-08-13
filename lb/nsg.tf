resource "oci_core_network_security_group" "this" {
  compartment_id = var.compartment_id
  display_name   = "${var.name}-lb"
  vcn_id         = var.vcn_id
}

resource "oci_core_network_security_group_security_rule" "this" {
  network_security_group_id = oci_core_network_security_group.this.id
  description               = "Allow http access from public load balance"
  direction                 = "INGRESS"
  protocol                  = 6 # TCP
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  stateless                 = false

  tcp_options {
    destination_port_range {
      max = 80
      min = 80
    }
  }
}