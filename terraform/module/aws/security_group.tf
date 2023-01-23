resource "aws_security_group" "nginx_alb_sec" {
    name = "nginx-alb-sec"
    description = "nginx-alb-sec"
    vpc_id = "${aws_vpc.nginx_vpc.id}"
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "nginx-alb-sec"
    }
}

resource "aws_security_group_rule" "nginx_alb_sec_rule_http" {
    security_group_id = "${aws_security_group.nginx_alb_sec.id}"
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}