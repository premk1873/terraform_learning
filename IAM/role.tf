resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"   # EC2 can assume the role
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "role_policy" {
  role = aws_iam_role.ec2_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  role = aws_iam_role.ec2_role.id
  name = "ec2-s2-role"
}

resource "aws_instance" "role_instance" {
  ami = "ami-05d3e0186c058c4dd"
  instance_type = "t3.micro"
  
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.id
  tags = {
    Name = "role-server"
  }
}