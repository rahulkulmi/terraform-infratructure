terraform {
  backend "s3" {
    region         = "us-west-2"
    key            = "terraform-newput-infrastructure.dev.tfstate"
    bucket         = "newput-dev.terraform"
    dynamodb_table = "newput-dev.terraform"
  }
}
