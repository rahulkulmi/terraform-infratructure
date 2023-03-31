resource "aws_ecr_repository" "ecr" {
  for_each             = toset(var.ecr_name)
  name                 = each.key
  image_tag_mutability = var.image_tag_mutability
  force_delete         = true # drop ECR repo if it is not empty.

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = var.tags
}
