############################################################
# Route53
############################################################
resource "aws_route53_record" "instance_a_record" {
  count = "${var.no-of-instances}"
  zone_id = "${var.dns_public_zone_id}"
  name = "${var.app_name}${count.index}.${var.dns_domain_name}"
  type    = "A"
  ttl     = "300"
  records = ["${element(split(",", var.instance-priv-ips), count.index)}"]
}

output "endpoint-1" {
  value = "${aws_route53_record.instance_a_record.0.fqdn}"
}

output "endpoint-2" {
  value = "${aws_route53_record.instance_a_record.1.fqdn}"
}

output "endpoint-3" {
  value = "${aws_route53_record.instance_a_record.2.fqdn}"
}