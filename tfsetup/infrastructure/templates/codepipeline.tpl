{
  "Statement": [
    {
      "Action": [
        "s3:PutObject",
        "s3:ListAllMyBuckets",
        "s3:GetObjectVersion",
        "s3:GetObject",
        "s3:GetBucketVersioning"
      ],
      "Resource": [
          "${artifact_bucket}",
          "${artifact_bucket}/*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "s3:PutObject"
      ],
      "Resource": [
        "arn:aws:s3:::codepipeline*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "codecommit:CancelUploadArchive",
        "codecommit:GetBranch",
        "codecommit:GetCommit",
        "codecommit:GetUploadArchiveStatus",
        "codecommit:UploadArchive"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "codedeploy:CreateDeployment",
        "codedeploy:GetApplicationRevision",
        "codedeploy:GetDeployment",
        "codedeploy:GetDeploymentConfig",
        "codedeploy:RegisterApplicationRevision"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ],
  "Version": "2012-10-17"
}