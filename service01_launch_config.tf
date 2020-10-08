resource "aws_launch_configuration" "service01" {
  image_id      = local.image_id
  instance_type = local.instance_type
  key_name = local.key_name
  security_groups = [ aws_security_group.service01_service_ports.id ]
  associate_public_ip_address = true
  user_data = file("user_data.sh")
  lifecycle { create_before_destroy = true }
}
