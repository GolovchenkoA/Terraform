variable "namespace" {
  description = "Unique resource naming"
  type = string
}

variable "ssh_keypair" {
    description = "optional ssh key"
    default = null
    type = string
  
}

variable "region" {
    description = "aws region"
    default = "us-east-1"
    type = string
}