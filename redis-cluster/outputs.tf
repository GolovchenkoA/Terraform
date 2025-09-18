output "redis_release_name" {
  value = helm_release.redis.name
}

output "redis_namespace" {
  value = helm_release.redis.namespace
}
