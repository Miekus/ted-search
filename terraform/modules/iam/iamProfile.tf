resource "aws_iam_instance_profile" "prodIamProfile" {
  name = "mateusz-kiszka-ted-search-${terraform.workspace}-profile"
  role = aws_iam_role.prodRole.name
}

resource "aws_iam_role" "prodRole" {
  name = "mateusz-kiszka-ted-search-${terraform.workspace}-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    created_by = "Mateusz Kiszka"
    bootcamp = "poland1"
  }
}
data "aws_iam_policy" "BootcampPolicy" {
  arn = "arn:aws:iam::644435390668:policy/BootcampPolicy"
}
resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.prodRole.name
  policy_arn = data.aws_iam_policy.BootcampPolicy.arn
}