data "aws_route53_zone" "selected" {
  name         = "aaron-evans-c04d.aws.sbx.hashicorpdemo.com"
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "future"
  type    = "A"
  ttl     = 1800
  records = [aws_eip.main.public_ip]
}