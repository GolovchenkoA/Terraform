# TODO this_lb_dns_name is not exist in alb module!!!!
output "lb_dns_name" {
    value = module.alb.this_lb_dns_name
}