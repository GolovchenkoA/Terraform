name            = "my-app-prod"
environment     = "prod"
replica_count   = 3
service_type    = "LoadBalancer"
image           = "jmalloc/echo-server"
container_port  = 8080
