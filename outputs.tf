output "public_ip" {
  value = module.instance["controllerworker"].public_ip
}
