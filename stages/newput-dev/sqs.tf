/*
module "sqs_Newput_Notification_Digest" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 3.0"

  name = "newput-${var.stage}-Notification-Digest"

  tags = module.tags.tags
}

module "sqs_Newput_DataChange_Dead" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 3.0"

  name       = "newput-${var.stage}-DataChange-Dead.fifo"
  fifo_queue = true

  tags = module.tags.tags
}
*/