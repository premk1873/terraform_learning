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

resource "aws_iam_user_login_profile" "login_data" {
  for_each = var.users
  user = each.key
  password_length = 8

  lifecycle {
    ignore_changes = [ 
      password_length,
      password_reset_required,
      pgp_key,
     ]
  }
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

output "login_creds" {
  value = {
    for user, creds in aws_iam_user_login_profile.login_data :
    user => {
    id = creds.id
    password = creds.password
    }
  }
  sensitive = true
}