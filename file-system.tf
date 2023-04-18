resource "aws_efs_file_system" "service_01" {
  creation_token = "service-01"

  tags = {
    Name = "MyProduct"
  }
}
