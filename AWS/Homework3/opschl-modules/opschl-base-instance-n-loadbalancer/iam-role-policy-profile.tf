resource "aws_iam_role" "opschl_iam_ec2_role" {
  count = (var.public_instance == true ? 1 : 0)
  name = "opschl_iam_ec2_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      name = "opschl_iam_ec2_role"
  }
}

resource "aws_iam_instance_profile" "opschl_instance_profile" {
  count = (var.public_instance == true ? 1 : 0)
  name = "opschl_instance_profile"
  role = aws_iam_role.opschl_iam_ec2_role[count.index].name
}

resource "aws_iam_role_policy" "opschl_iam_role_policy" {
  count = (var.public_instance == true ? 1 : 0)
  name = "opschl_iam_role_policy"
  role = aws_iam_role.opschl_iam_ec2_role[count.index].id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

