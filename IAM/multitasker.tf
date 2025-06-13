resource "aws_iam_user" "master" {
  name = "master"
}

resource "aws_iam_user_policy_attachment" "m_policies" {
  for_each   = var.user-policies
  user       = aws_iam_user.master.name
  policy_arn = each.value
}

variable "user-policies" {
  default = {
    admin      = "arn:aws:iam::aws:policy/AdministratorAccess",
    cloudwatch = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  }
}