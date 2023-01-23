resource "aws_alb" "nginx_alb" {
    name = "nginx-load-balancer"
    security_groups = ["${aws_security_group.nginx_alb_sec.id}"]
    subnets = ["${aws_subnet.nginx_public_subnet_1a.id}", "${aws_subnet.nginx_public_subnet_1c.id}", "${aws_subnet.nginx_public_subnet_1d.id}"]
}

resource "aws_alb_listener" "nginx_alb_listener" {
    port = "80"
    protocol = "HTTP"
    load_balancer_arn = "${aws_alb.nginx_alb.arn}"
    default_action {
        type = "fixed-response"
        fixed_response {
            content_type = "text/plain"
            status_code = "200"
            message_body = "ok"
        }
    }
}