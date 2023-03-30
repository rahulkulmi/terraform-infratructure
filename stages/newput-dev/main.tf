locals {
  tags = merge(var.additional_tags, {
    Repo        = var.repo
    Environment = var.stage
    Project     = var.project
    Version     = var.app_version
    Terraform   = "true"
    # TerraformVersion = var.terraform_version
  })
}

# resource "aws_sns_topic" "ecr_notifications" {
#   name = "ECS_alerts_${var.stage}"

#   tags = module.tags.tags
# }

resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
  tags = local.tags
}

/*
resource "aws_ecr_repository" "fc_integration" {
  # name                 = "newput/node-terraform"

  dynamic "ecr_repository_name" {
    for_each = var.newput_repository_name
    iterator = name
    content {
      # name = setting.value["name"]
      name = name.value
    }
  }

  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = var.tags
}
*/