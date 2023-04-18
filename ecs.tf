resource "aws_ecs_cluster" "ecs_cluster" {
  name = "service_cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "service_01" {
  family                = "service-01"
  container_definitions = file("task-definitions/service-01.json")

  volume {
    name = "service-storage"

    docker_volume_configuration {
      scope         = "shared"
      autoprovision = true
      driver        = "local"

      driver_opts = {
        "type"   = "nfs"
        "device" = "${aws_efs_file_system.service_01.dns_name}:/"
        "o"      = "addr=${aws_efs_file_system.service_01.dns_name},rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport"
      }
    }
  }
}


# https://registry.terraform.io/modules/hendrixroa/iam-role-ecs/aws/latest

resource "aws_ecs_service" "jenkins_ecs" {
  name    = "jenkins_ecs"
  cluster = aws_ecs_cluster.ecs_cluster.id
  # task_definition = aws_ecs_task_definition.service_01.arn
  # task_definition = module.aws_iam_role.ecs_task
  desired_count = 3
  iam_role      = module.iam-role-ecs.ecs_service
  depends_on    = [module.iam-role-ecs.ecs_service]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.service01_target_group.arn
    container_name   = "jenkins_ecs"
    container_port   = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-east-1a, us-east-1b]"
  }
}

resource "aws_ecs_capacity_provider" "service01_capacity_provider" {
  name = "service01-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.service01_autoscaling_group.arn
  }
}
