terraform {
  required_version = ">=0.15"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    local = {
      version = "~> 2.0"
    }
  }
}

#variable "nouns" {
#    description  = "A list of nouns"
#    type = list(string)
#}
#variable "adjectives" {
#    description  = "A list of adjectives"
#    type = list(string)
#}

variable "words" {
  description = "words (in terraform.tfvars)"
  type        = object({
    nouns      = list(string),
    adjectives = list(string),
    verbs      = list(string),
    adverbs    = list(string),
    numbers    = list(number),
  })

  validation {
    condition     = length(var.words["nouns"]) >= 5
    error_message = "At least 5 nouns must be supplied"
  }

  validation {
    condition     = length(var.words["numbers"]) >= 5
    error_message = "Max allowed size is 5"
  }
}

resource "random_shuffle" "random_nouns" {
  input = var.words["nouns"]
}
resource "random_shuffle" "random_adjectives" {
  input = var.words["adjectives"]
}
resource "random_shuffle" "random_verbs" {
  input = var.words["verbs"]
}
resource "random_shuffle" "random_adverbs" {
  input = var.words["adverbs"]
}
resource "random_shuffle" "random_numbers" {
  input = var.words["numbers"]
}

#output "mad_libsMy2" {
##  value = templatefile("${path.module}/templates/alice_short2.txt",
#  value = templatefile(local.variables_template_path2,
#    {
#      nouns      = random_shuffle.random_nouns.result
#      adjectives = random_shuffle.random_adjectives.result
#            verbs      = random_shuffle.random_verbs.result
#            adverbs    = random_shuffle.random_adverbs.result
#            numbers    = random_shuffle.random_numbers.result
#    }
#  )
#}

#output "mad_libs" {
#  value = templatefile("${path.module}/templates/alice.txt",
#    {
#      nouns      = random_shuffle.random_nouns.result
#      adjectives = random_shuffle.random_adjectives.result
#      verbs      = random_shuffle.random_verbs.result
#      adverbs    = random_shuffle.random_adverbs.result
#      numbers    = random_shuffle.random_numbers.result
#    })
#}


#----------Iterating over variables

locals {
  variables_template_path = "${path.module}/templates/variables.tftpl"
}

locals {
  variables_template_path2 = "${path.module}/templates/alice_short2.txt"
}

#Generate
#resource "local_file" "variables_template" {
#  content  = "%%{ for v in variables ~} \n val $${v} \n %%{ endfor ~}"
##  filename = "${path.module}/templates/variables.tftpl"
#  filename = local.variables_template_path
#}

#path already should be exist
#output "iterate_over_variables" {
#  value = templatefile("${path.module}/templates/variables.tftpl",
#    {
#      variables    = random_shuffle.random_numbers.result
#    })
#}

#path from variable
# !!! It works only if the file already exists
#output "iterate_over_variables_locals" {
#  value = templatefile(local.variables_template_path,
#    {
#      variables    = random_shuffle.random_numbers.result
#    })
#}
