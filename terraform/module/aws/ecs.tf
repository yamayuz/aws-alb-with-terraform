resource "aws_ecs_cluster" "nginx_ecs_cluster" {
    name = "nginx"
}

resource "aws_ecs_service" "nginx_ecs_service" {
    name = "nginx"
    depends_on = ["aws_alb_listener_rule.nginx_alb_listener_rule"]
    cluster = "${aws_ecs_cluster.nginx_ecs_cluster.name}"
    launch_type = "FARGATE"
    desired_count = "1"
    task_definition = "${aws_ecs_task_definition.nginx_ecs_task.arn}"
    health_check_grace_period_seconds = 3600
    network_configuration {
        subnets  = ["${aws_subnet.nginx_private_subnet_1a.id}"]
        security_groups = ["${aws_security_group.nginx_ecs_sec.id}"]
    }
    load_balancer {
        target_group_arn = "${aws_alb_target_group.nginx_alb_target_group.arn}"
        container_name   = "nginx"
        container_port   = "80"
    }
}

resource "aws_ecs_task_definition" "nginx_ecs_task" {
    family = "nginx"
    requires_compatibilities = ["FARGATE"]
    cpu = "256"
    memory = "512"
    network_mode = "awsvpc"
    container_definitions = <<EOL
    [
        {
            "name": "nginx",
            "image": "nginx:1.18",
            "portMappings": [
                {
                    "containerPort": 80,
                    "hostPort": 80
                }
            ]
        }
    ]
    EOL
}