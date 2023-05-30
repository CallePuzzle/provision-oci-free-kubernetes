resource "oci_bastion_bastion" "k8s" {
  count = 0
  #Required
  bastion_type                 = "STANDARD"
  compartment_id               = var.compartment_id
  target_subnet_id             = module.vcn.subnet_id["bastion"]
  client_cidr_block_allow_list = ["0.0.0.0/0"]
}

#resource "oci_bastion_session" "test_session" {
#    #Required
#    bastion_id = oci_bastion_bastion.k8s.id
#    key_details {
#        #Required
#        public_key_content = file("~/.ssh/id_rsa.pub")
#    }
#    target_resource_details {
#        #Required
#        session_type = "MANAGED_SSH"
#
#        #Optional
#        target_resource_fqdn = var.session_target_resource_details_target_resource_fqdn
#        target_resource_id = oci_bastion_target_resource.test_target_resource.id
#        target_resource_operating_system_user_name = oci_identity_user.test_user.name
#        target_resource_port = var.session_target_resource_details_target_resource_port
#        target_resource_private_ip_address = var.session_target_resource_details_target_resource_private_ip_address
#    }
#
#    #Optional
#    display_name = var.session_display_name
#    key_type = var.session_key_type
#    session_ttl_in_seconds = var.session_session_ttl_in_seconds
#}