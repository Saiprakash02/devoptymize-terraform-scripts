#################################Create a IAM User ###################################
resource "aws_iam_user" "iam_user" {
  name = var.iam_user
  permissions_boundary = var.permission_boundary_arn
  
  
}

resource "aws_iam_user_login_profile" "iam_user" {
  user                    = aws_iam_user.iam_user.name
  password_reset_required = var.password_reset_required
}

resource "aws_iam_user_group_membership" "iam_user_group_membership" {
  user    = aws_iam_user.iam_user.name
  groups  = var.existing_group_name
}

resource "aws_iam_user_policy" "custom_policy" {
  count = var.apply_custom_policy ? 1 : 0  # Conditionally apply the custom policy
  name = var.custom_policy_name
  user = aws_iam_user.iam_user.name  # Reference the IAM user without [0]
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = var.custom_policy_actions,
        Resource = var.custom_policy_resources,
      },
    ],
  })
}
resource "aws_iam_policy_attachment" "managed_policy_attachment" {
  count = var.apply_managed_policy ? 1 : 0  # Conditionally apply the managed policy
  name       = "ManagedPolicyAttachment"
  policy_arn = var.managed_policy_arn
  users      = [aws_iam_user.iam_user.name]  # Reference the IAM user without [0]
}
