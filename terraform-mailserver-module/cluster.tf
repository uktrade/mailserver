module "ecs_cluster" {
  source = "infrablocks/ecs-cluster/aws"
  version = "1.2.0-rc.2"

  region = data.aws_region.current.name
  vpc_id = "${var.vpc_id}"
  subnet_ids = "${var.subnet_ids}"

  component = "mailserver"
  deployment_identifier = "${var.environment}"

  cluster_name = "mailserver"
  cluster_instance_ssh_public_key_path = "${var.ssh_key_path}"
  cluster_instance_type = "${var.instance_type}"

  security_groups = [var.security_groups]

  cluster_minimum_size = 1
  cluster_maximum_size = 1
  cluster_desired_capacity = 1

  cluster_instance_user_data_template = file("${path.module}/files/user_data.sh")
}
