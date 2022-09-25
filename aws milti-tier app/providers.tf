provider "aws" {
   region  = var.region

   default_tags {
    tags = {
      Environment = "avebury sandbox"
      Owner       = "Artem Holochenko"
    }
  }
}