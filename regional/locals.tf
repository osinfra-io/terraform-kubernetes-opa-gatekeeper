# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  env = lookup(local.env_map, var.environment, "none")

  env_map = {
    "non-production" = "nonprod"
    "production"     = "prod"
    "sandbox"        = "sb"
  }
}
