{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "codebuild:CreateReportGroup",
        "codebuild:CreateReport",
        "iam:PassRole",
        "codebuild:UpdateReport",
        "s3:GetBucketVersioning",
        "codebuild:BatchPutTestCases",
        "s3:GetObjectVersion"
      ],
      "Resource": [
        "${artifact_bucket}",
        "${artifact_bucket}/*"
      ],
      "Effect": "Allow"
    },
    {
      "Effect": "Allow",
      "Resource": ${codebuild_project_packages},
      "Action": [
        "codebuild:*"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": ${codebuild_project_packages},
      "Action": [
        "codebuild:CreateReportGroup",
        "codebuild:CreateReport",
        "codebuild:BatchPutTestCases",
        "codebuild:UpdateReport",
        "iam:PassRole"
      ] 
    }
  ]
}