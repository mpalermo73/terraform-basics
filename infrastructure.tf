provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.default.id

}

# resource "aws_default_route_table" "route_table" {
#   default_route_table_id = aws_vpc.default.default_route_table_id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.gw.id
#   }
# }

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "alt" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_lb" "service01_lb" {
  name            = "service01-lb"
  security_groups = [aws_security_group.service01_service_ports.id]
  subnets         = [aws_subnet.main.id, aws_subnet.alt.id]
}

resource "aws_lb_listener" "service01_lb_listener" {
  load_balancer_arn = aws_lb.service01_lb.arn
  port              = local.service01_service_port
  protocol          = local.service01_service_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service01_target_group.arn
  }
}

resource "aws_lb_target_group" "service01_target_group" {
  port     = "80"
  protocol = "HTTP"
  vpc_id   = aws_vpc.default.id
}
