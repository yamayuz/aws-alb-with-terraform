resource "aws_alb" "nginx_alb" {
    name = "nginx-load-balancer"
    security_groups = ["${aws_security_group.nginx_alb_sec.id}"]
    subnets = ["${aws_subnet.nginx_public_subnet_1a.id}", "${aws_subnet.nginx_public_subnet_1c.id}"]
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

resource "aws_alb_target_group" "nginx_alb_target_group" {
    name = "nginx-target-group"
    vpc_id = "${aws_vpc.nginx_vpc.id}"
    port = 80
    protocol = "HTTP"
    target_type = "ip"
    health_check {
        port = 80
        path = "/"
    }
}

resource "aws_alb_listener_rule" "nginx_alb_listener_rule" {
    listener_arn = "${aws_alb_listener.nginx_alb_listener.arn}"
    action {
        type = "forward"
        target_group_arn = "${aws_alb_target_group.nginx_alb_target_group.arn}"
    }
    condition {
        path_pattern {
            values = ["*"]
        }
    }
}