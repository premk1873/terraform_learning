variable "users" {
  default = {
    ec2user = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    s3user  = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    rdsuser = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  }
}

resource "aws_iam_user" "users" {
  for_each = var.users
  name     = each.key
}

resource "aws_iam_user_policy_attachment" "attachments" {
  for_each = var.users

  user       = aws_iam_user.users[each.key].name
  policy_arn = each.value

  depends_on = [aws_iam_user.users]
}

resource "aws_iam_access_key" "keys" {
  for_each = var.users
  user     = aws_iam_user.users[each.key].name
}

output "access_keys" {
  value = {
    for user, creds in aws_iam_access_key.keys :
    user => {
      access_key_id     = creds.id
      secret_access_key = creds.secret
    }
  }
  sensitive = true
}
