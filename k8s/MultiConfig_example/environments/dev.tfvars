name            = "my-app-dev"
environment     = "dev"
replica_count   = 2
service_type    = "LoadBalancer"
image           = "jmalloc/echo-server"
container_port  = 8080
