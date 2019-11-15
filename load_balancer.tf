resource "aws_lb" "application_load_balancer" {
  name = "ecs-application-lb"
  load_balancer_type = "application"
  subnets = ["${aws_subnet.subnet_for_ecs.id}"]
}

resource "aws_alb_listener" "ecs_application_lb_listener" {
  "default_action" {
    type = "foward"
  }
  load_balancer_arn = "${aws_lb.application_load_balancer.arn}"
  port = 80
  protocol = "HTTP"
}

resource "aws_alb_target_group" "ecs_application_lb_target_group" {
  name = "ecs-test-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = "${aws_vpc.vpc_for_ecs.id}"
}