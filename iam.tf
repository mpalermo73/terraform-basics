
# resource "aws_iam_role" "iam_role_ecs" {
#   name               = "iam_role_ecs"
#   assume_role_policy = aws_iam_role_policy.iam_role_policy_ecs.arn

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   # assume_role_policy = jsonencode({
#   #   Version = "2012-10-17"
#   #   Statement = [
#   #     {
#   #       Action = "sts:AssumeRole"
#   #       Effect = "Allow"
#   #       Sid    = ""
#   #       Principal = {
#   #         Service = "ecs.amazonaws.com"
#   #       }
#   #     },
#   #   ]
#   # })
# }

# resource "aws_iam_role_policy" "iam_role_policy_ecs" {
#   name = "iam_role_policy_ecs"
#   # role = aws_iam_role.iam_role_ecs.arn

#   policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Action" : "sts:AssumeRole",
#         "Principal" : {
#           "Service" : "ecs.amazonaws.com"
#         },
#         "Effect" : "Allow",
#         "Sid" : ""
#       }
#     ]
#   })

#   #   # Terraform's "jsonencode" function converts a
#   #   # Terraform expression result to valid JSON syntax.
#   #   policy = jsonencode({
#   #     Version = "2012-10-17"
#   #     Statement = [
#   #       {
#   #         Action = [
#   #           "ec2:Describe*"
#   #         ]
#   #         Effect   = "Allow"
#   #         Resource = "*"
#   #       },
#   #     ]
#   #   })
# }


# data "aws_iam_policy_document" "iam_role_ecs_policy_document" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "ec2:Describe*",

#     ]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_role_policy_attachment" "iam_role_ecs_policy_attachment" {
#   role       = aws_iam_role.iam_role_ecs.name
#   policy_arn = aws_iam_policy.iam_role_ecs_policy_document.arn
# }

# resource "aws_iam_service_linked_role" "IAMServiceLinkedRole2" {
#   aws_service_name = "ecs.application-autoscaling.amazonaws.com"
# }

# resource "aws_iam_service_linked_role" "IAMServiceLinkedRole4" {
#   aws_service_name = "ecs.amazonaws.com"
#   description      = "Role to enable Amazon ECS to manage your cluster."
# }
