# security groups
resource "aws_security_group" "allow_all_tcp" {
  name        = "allow_all_tcp"
  description = "Allow all inbound tcp traffic over port 443"
  vpc_id      = aws_vpc.main.id # data.aws_vpc.main.id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # tags = local.tags
  tags = merge(local.tags, {
    Name = "np-${var.stage}-sg-allow-all-tcp"
  })
}
/*
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = local.tags
}

resource "aws_security_group" "allow_all_from_nat_gateway" {
  name        = "allow_all_from_nat_gateway"
  description = "Allow all inbound traffic from NAT"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "${data.aws_nat_gateway.this.public_ip}/32"
    ]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = local.tags
}

## per-application sgs

resource "aws_security_group" "fc_integration" {
  name        = "fc-integration"
  description = "security group for FC.Integration API"
  vpc_id      = data.aws_vpc.main.id

  egress {
    description      = "all"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "http whitelist"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = concat(
      var.fc_integration_ips
    ) # add you server ip which needed to allow
  }
  ingress {
    description = "https whitelist"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = concat(
      var.fc_integration_ips
    ) # add you server ip which needed to allow
  }
  ingress {
    description = "NonProd-NAT http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      "${data.aws_nat_gateway.this.public_ip}/32",
      "192.169.10.1/32" # TEMP of old account
    ]
  }
  ingress {
    description = "NonProd-NAT https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      "${data.aws_nat_gateway.this.public_ip}/32",
      "192.169.10.1/32" # TEMP of old account
    ]
  }

  tags = local.tags
}
*/
