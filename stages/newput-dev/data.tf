data "aws_availability_zones" "available" {

}

# data "aws_vpc" "main" {
#   tags = {
#     Name = var.vpc_name
#   }
# }

# data "aws_nat_gateway" "this" {
#   vpc_id = data.aws_vpc.main.id
# }

/*
## graylog config
data "aws_route53_zone" "fc" {
  provider = aws.dns
  name     = "newput.click."
}

data "aws_ami" "this" {
  filter {
    name   = "name"
    values = ["newput-ubuntu20-graylog-server-2022-06-01T17-47-12Z"]
  }
  most_recent = true
  owners      = ["self"]
}

data "aws_subnet" "private" {
  vpc_id = data.aws_vpc.main.id
  tags = {
    Name = "newput-dev-private-us-west-2a"
  }
}

data "aws_security_group" "security_groups" {
  count = length(var.graylog_server_security_group_names)
  name  = var.graylog_server_security_group_names[count.index]
}
*/
