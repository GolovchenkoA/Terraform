terraform {
  required_providers {
  

    local = {
      version = "~> 2.0"
    }
  }
}

resource "local_file" "foo" {
    content  = "foo!"
    filename = "${path.module}/foo.bar"
}