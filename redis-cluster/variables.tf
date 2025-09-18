variable "namespace" {
  default = "redis"
}

variable "kubeconfig" {
  type        = string
  description = "Path to the kubeconfig file"
  # default     =  "~/.kube/config"
  default     =  "C:\\Users\\golov\\.kube\\config"
}