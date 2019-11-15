resource "aws_ecs_service" "" {
  name = "simple-web-app"
  task_definition = ""
  cluster = "${aws_ecs_cluster.test-ecs-cluster.id}"
  desired_count = 3

  load_balancer {
    target_group_arn = "${aws_alb_target_group.ecs_application_lb_target_group.arn}"
    container_name = "simple-web-app"
    container_port = 80
  }
}

resource "aws_ecs_cluster" "test-ecs-cluster" {
  name = "simple-ecs-cluster"
}

data "aws_caller_identity" "current" {}

data "template_file" "task_definition" {
  template = "${file("${path.module}/task-definitions/task-definition.json")}"

  vars {
    account_no = "${data.aws_caller_identity.current.account_id}"
  }
}

resource "aws_ecs_task_definition" "test-ecs-task-definition" {
  container_definitions = "${data.template_file.task_definition.rendered}"
  family = "web-service"

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [eu-west-2a]"
  }
}