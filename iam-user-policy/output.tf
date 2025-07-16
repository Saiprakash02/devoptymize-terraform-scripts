output "password" {
  value = aws_iam_user_login_profile.iam_user.password
  sensitive = true
}
