/*
resource "aws_waf_ipset" "ipset" {
  name = "newput_network_ip_range"

  ip_set_descriptors {
    type  = "IPV4"
    value = "64.207.200.0/22"
  }
}

resource "aws_waf_rule" "wafrule" {
  depends_on  = [aws_waf_ipset.ipset]
  name        = "NewputNetworkIPRule"
  metric_name = "NewputNetworkIPRule"

  predicates {
    data_id = aws_waf_ipset.ipset.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "waf_acl" {
  depends_on = [
    aws_waf_ipset.ipset,
    aws_waf_rule.wafrule,
  ]
  name        = "NewputNetworkIPWebACL"
  metric_name = "NewputNetworkIPWebACL"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.wafrule.id
    type     = "REGULAR"
  }
}
*/