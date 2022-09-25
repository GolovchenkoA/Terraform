output "db_password" {
  sensitive = true  # added because of warning
  value = module.database.db_config.password
}

output "lb_dns_name" {
  value = module.autoscaling.lb_dns_name
}