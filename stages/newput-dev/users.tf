# special user for microservices
resource "aws_iam_user" "svcusr" {
  name = "np-${var.stage}-svcusr"
}
# policy for this user
resource "aws_iam_policy" "svc_usr_policy" {
  name        = "np-${var.stage}-svcusr-policy"
  description = "policy for svcusr"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # {
      #   Action   = ["sqs:*"]
      #   Effect   = "Allow"
      #   Resource = "${module.sqs_Newput_Notification_Digest.sqs_queue_arn}"
      # },
      # {
      #   Action   = ["sqs:*"]
      #   Effect   = "Allow"
      #   Resource = "${module.sqs_Newput_DataChange_Dead.sqs_queue_arn}"
      # },
      # first is for bucket itself
      {
        Action   = ["s3:*"]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.newput_react_web.arn}"
      },
      # second for the any object in the bucket
      {
        Action   = ["s3:*"]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.newput_react_web.arn}/*"
      },
      {
        Action = [
          "ssm:GetParameters",
          "secretsmanager:GetSecretValue"
        ]
        Effect = "Allow"
        Resource = [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "svc_usr_policy_attach" {
  user       = aws_iam_user.svcusr.name
  policy_arn = aws_iam_policy.svc_usr_policy.arn
}
