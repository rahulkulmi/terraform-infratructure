module "ecr_repository" {
  source = "../../modules/ecr"

  ecr_name             = var.repository_names
  image_tag_mutability = var.image_tag_mutability
  scan_on_push         = var.scan_on_push

  tags = local.tags
}
