provider "aws" {
  region = "us-east-1"
  access_key = "AKIAUJGNL66PZCBS2UVQ"
  secret_key = "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"
}


resource "aws_iam_user" "terraform_user" {
  name = "terraform-cs423-devops"
}

resource "aws_iam_user_policy_attachment" "admin_attachment" {
  user       = aws_iam_user.terraform_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "terraform_user_key" {
  user = aws_iam_user.terraform_user.name
}