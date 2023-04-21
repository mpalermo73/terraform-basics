
# resource "aws_iam_role" "iam_role_ecs" {
#   name = "iam_role_ecs"
#   # assume_role_policy = aws_iam_role_policy.iam_role_policy_ecs.id

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ecs.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy" "iam_role_policy_ecs" {
#   name = "iam_role_policy_ecs"
#   role = aws_iam_role.iam_role_ecs.id

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "ec2:Describe*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }


