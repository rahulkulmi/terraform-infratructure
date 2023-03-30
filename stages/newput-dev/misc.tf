# resource "aws_flow_log" "newput_prod_vpc_flow_log" {
#   iam_role_arn    = "arn:aws:iam::001765002321:role/AWSControlTower_VPCFlowLogsRole"
#   log_destination = aws_cloudwatch_log_group.newput_prod_cloudwatch_group.arn
#   traffic_type    = "ALL"
#   vpc_id          = data.aws_vpc.main.id

#   tags = module.tags.tags
# }

# resource "aws_cloudwatch_log_group" "newput_prod_cloudwatch_group" {
#   name = "newput-prod-vpc-flow-log"

#   tags = module.tags.tags
# }

/*
resource "aws_iam_account_password_policy" "newput_dev_account_password_policy" {
  minimum_password_length      = 14
  require_lowercase_characters = true
  require_numbers              = true
  require_uppercase_characters = true
  require_symbols              = true
  password_reuse_prevention    = 24
  max_password_age             = 90
}
*/