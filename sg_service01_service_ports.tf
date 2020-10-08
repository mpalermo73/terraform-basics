resource "aws_security_group" "service01_service_ports" {
  name        = "service01_service_ports"
  description = "Allow inbound service traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    description = "SSH from Erff"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http from Erff"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "service01_service_ports"
  }
}
