resource "aws_placement_group" "service01" {
  name     = "service01"
  strategy = "cluster"
}

# Cannot delete launch configuration because it is attached to AutoScalingGroup
# https://github.com/hashicorp/terraform/issues/532#issuecomment-272263827

resource "aws_autoscaling_group" "service01_autoscaling_group" {
  lifecycle { create_before_destroy = true }
  name = "service01-${aws_launch_configuration.service01.name}"
  desired_capacity          = 2
  max_size                  = 4
  min_size                  = 2
#  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  termination_policies = ["OldestInstance"]
  wait_for_capacity_timeout = "6m"
  launch_configuration      = aws_launch_configuration.service01.name
  vpc_zone_identifier = [ aws_subnet.main.id, ]

  initial_lifecycle_hook {
    name                 = "service01_lifecycle_hook"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 30
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
  }

  tag {
    key                 = "Name"
    value               = "service01"
    propagate_at_launch = true
  }

  timeouts {
    delete = "10m"
  }
}

resource "aws_autoscaling_attachment" "service01_autoscaling_attachment" {
  autoscaling_group_name = aws_autoscaling_group.service01_autoscaling_group.id
  alb_target_group_arn   = aws_lb_target_group.service01_target_group.arn
}
