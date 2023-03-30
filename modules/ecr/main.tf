resource "aws_ecr_repository" "ecr" {
  for_each             = toset(var.ecr_name)
  name                 = each.key
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = var.tags
}
