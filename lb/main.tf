data "oci_load_balancer_shapes" "this" {
  compartment_id = var.compartment_id
}

resource "oci_load_balancer_load_balancer" "this" {

  compartment_id = var.compartment_id
  display_name   = "${var.name}-lb"

  subnet_ids                 = var.subnet_ids
  is_private                 = false
  network_security_group_ids = [oci_core_network_security_group.this.id]

  shape = data.oci_load_balancer_shapes.this.shapes[0].name
  shape_details {
    minimum_bandwidth_in_mbps = 10
    maximum_bandwidth_in_mbps = 10
  }
}

resource "oci_load_balancer_backend_set" "this" {
  load_balancer_id = oci_load_balancer_load_balancer.this.id
  name             = "${var.name}-backend-set"
  policy           = "ROUND_ROBIN"

  health_checker {
    protocol          = "HTTP"
    url_path          = "/"
    port              = 80
    retries           = 3
    timeout_in_millis = 3000
    return_code       = 404
  }
}

resource "oci_load_balancer_backend" "this" {
  backendset_name  = oci_load_balancer_backend_set.this.name
  ip_address       = var.backend_ip_address
  load_balancer_id = oci_load_balancer_load_balancer.this.id
  port             = 80
}

resource "oci_load_balancer_listener" "this" {
  default_backend_set_name = oci_load_balancer_backend_set.this.name
  load_balancer_id         = oci_load_balancer_load_balancer.this.id
  name                     = "${var.name}-listener"
  port                     = 80
  protocol                 = "HTTP"
}