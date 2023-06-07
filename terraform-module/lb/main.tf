data "oci_load_balancer_shapes" "this" {
  compartment_id = var.compartment_id
}

resource "oci_load_balancer_load_balancer" "this" {

  compartment_id = var.compartment_id
  display_name   = "k0s-lb"

  subnet_ids = var.subnet_ids

  shape = data.oci_load_balancer_shapes.this.shapes[0].name
  shape_details {
    minimum_bandwidth_in_mbps = 10
    maximum_bandwidth_in_mbps = 10
  }
}

resource "oci_load_balancer_backend_set" "this" {
  load_balancer_id = oci_load_balancer_load_balancer.this.id
  name             = "k0s-backend-set"
  policy           = "ROUND_ROBIN"

  health_checker {
    protocol          = "HTTP"
    url_path          = "/"
    port              = 80
    retries           = 3
    timeout_in_millis = 3000
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
  name                     = "k0s-listener"
  port                     = 80
  protocol                 = "HTTP"
}