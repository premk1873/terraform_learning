resource "aws_iam_user" "custom_user" {
  name = "custom_user"
}

resource "aws_iam_user_policy" "readonly_inline_policy" {
  name = "ReadOnlyEssentialInline"
  user = aws_iam_user.custom_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "s3:Get*",
          "s3:List*",
          "lambda:Get*",
          "lambda:List*",
          "cloudwatch:Describe*",
          "cloudwatch:Get*",
          "logs:Describe*",
          "logs:Get*",
          "logs:Filter*"
        ]
        Resource = "*"
      }
    ]
  })
}