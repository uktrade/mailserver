locals {
  name        = "mailserver"
  environment = "${var.environment}"
}

data "template_file" "ecs_task" {
  template = "${file("tasks/service.json")}"

  vars = {
    mailserver_registry = "${var.mailserver_registry}"
    email_domain = "${var.email_domain}"
    certbot_email = "${var.certbot_email}"
    mail_username = "${var.mail_username}"
    mail_password = "${var.mail_password}"
  }
}

resource "aws_ecs_task_definition" "service" {
  family                = "mailserver-service"
  container_definitions = "${data.template_file.ecs_task.rendered}"

  network_mode = "bridge"

  volume {
    name      = "maildata"
    host_path = "/ecs/maildata"
  }

  volume {
    name      = "letsencrypt"
    host_path = "/ecs/letsencrypt"
  }
}

resource "aws_ecs_service" "mailserver" {
  name            = "mailserver"
  cluster         = "${var.cluster_arn}"
  task_definition = "${aws_ecs_task_definition.service.arn}"
  desired_count   = 1

  placement_constraints {
    type       = "distinctInstance"
  }
}
