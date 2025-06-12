# resource "aws_iam_user" "ec2user" {
#   name = "terra-ec2user"
# }

# resource "aws_iam_access_key" "key1" {
#   user = aws_iam_user.ec2user.name
# }

# resource "aws_iam_user_policy_attachment" "ec2_policy" {
#   user = aws_iam_user.ec2user.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
# }

# resource "aws_iam_user" "s3user" {
#   name = "terra-s3user"
# }

# resource "aws_iam_access_key" "key2" {
#   user = aws_iam_user.s3user.name
# }

# resource "aws_iam_user_policy_attachment" "s3_policy" {
#   user = aws_iam_user.s3user.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
# }

# resource "aws_iam_user" "rdsuser" {
#   name = "terra-rdsuser"
# }

# resource "aws_iam_access_key" "key3" {
#   user = aws_iam_user.rdsuser.name
# }

# resource "aws_iam_user_policy_attachment" "rds_policy" {
#   user = aws_iam_user.rdsuser.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
# }


