resource "aws_efs_file_system" "service01_efs_file_system" {
  creation_token = "service-01"

  tags = {
    Name = "MyProduct"
  }
}
