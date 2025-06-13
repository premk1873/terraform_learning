resource "aws_iam_group" "grp" {
  name = "new-admin"
}

resource "aws_iam_group_policy_attachment" "admin_policy" {
  group      = aws_iam_group.grp.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_membership" "members" {
  for_each = var.users
  name     = "admins"
  users = [
    aws_iam_user.users[each.key].name
  ]
  group = aws_iam_group.grp.name
}