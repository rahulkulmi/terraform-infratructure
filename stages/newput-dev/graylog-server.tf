/*
resource "aws_instance" "this" {
  count                       = var.instance_count
  ami                         = data.aws_ami.this.id
  instance_type               = "t3.large"
  associate_public_ip_address = "false"
  availability_zone           = "us-east-1d"
  ebs_optimized               = "true"
  disable_api_termination     = "false"
  key_name                    = "newput-dev-graylog"

  root_block_device {
    delete_on_termination = "true"
    volume_size           = "120"
    volume_type           = "gp2"
  }

  tags = merge(module.tags.tags,
    {
      "Name" = var.instance_count > 1 || var.use_num_suffix ? format("%s-%d", var.name, count.index + 1) : var.name
  })

  vpc_security_group_ids = data.aws_security_group.security_groups.*.id

  subnet_id = data.aws_subnet.private.id
}

resource "aws_route53_record" "graylog" {
  zone_id  = data.aws_route53_zone.fc.zone_id
  name     = "graylog"
  type     = "A"
  ttl      = "300"
  records  = aws_instance.this.*.private_ip
  provider = aws.dns
}
*/