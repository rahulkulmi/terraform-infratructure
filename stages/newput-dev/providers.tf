provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# provider "aws" {
#   alias  = "dns"
#   region = var.region
#   # assume_role {
#   #   role_arn = "arn:aws:iam::11111:role/newput-dev-Route53FullAccess"
#   # }
# }
