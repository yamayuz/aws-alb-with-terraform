# -----------------------------------------------
# Route53 Hosted Zone
# -----------------------------------------------
data "aws_route53_zone" "nginx_route53_zone" {
    name = "${var.domain}"
    private_zone = false
}