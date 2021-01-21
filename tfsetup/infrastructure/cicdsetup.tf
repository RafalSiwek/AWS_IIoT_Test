resource "aws_codecommit_repository" "codecommit-repository-test" {
    repository_name = var.repo-name
    description = "CICD test repo name"
    default_branch = var.branch_name
    tags =merge(
    local.common_tags,
    {
      Name = var.repo-name
    }
  )    
}

resource "aws_s3_bucket" "build_artifact_bucket" {
    bucket = "${local.resource_prefix}-test-artifact-bucket"
    acl = "private"
    force_destroy = true

    tags =merge(
        local.common_tags,{
            Name = "${local.resource_prefix}build_artifact_bucket"
        }
    )
}



resource "aws_codebuild_project" "first-build" {

    name = "${local.resource_prefix}-first-test-build"
    description = "First test build without actions"
    service_role = aws_iam_role.codebuild_role.arn

    artifacts {
      type = "CODEPIPELINE"
    }
    
    environment {
        compute_type = "BUILD_GENERAL1_SMALL"
        image = "aws/codebuild/standard:5.0"
        type = "LINUX_CONTAINER"
    }
    source {
        type = "CODEPIPELINE"
        buildspec = "src/buildspec.yml"
    }
    tags =merge(
        local.common_tags,{
            Name = "${local.resource_prefix}first-test-build"
        }
    )

}

resource "aws_codebuild_project" "unittest1-codecommit-repository-test" {
    
    name = "${local.resource_prefix}-unit-test1-build"
    description = "First unit test"
    service_role = aws_iam_role.codebuild_role.arn
    
    artifacts {
      type = "CODEPIPELINE"
    }
    environment {
        compute_type = "BUILD_GENERAL1_SMALL"
        image = "aws/codebuild/standard:5.0"
        type = "LINUX_CONTAINER"
    }
    source {
        type = "CODEPIPELINE"
        buildspec = "test/buildspec.yml"
    }
    tags =merge(
        local.common_tags,{
            Name = "${local.resource_prefix}unit-test1-build"
        }
    )  
}

resource "aws_codepipeline" "cicd-management" {
  name = "${local.resource_prefix}-cicd-management-test"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    type = "S3"
    location = aws_s3_bucket.build_artifact_bucket.bucket
  }
  stage {
    name = "Source"

    action {
      name = "Source"
      category = "Source"
      owner = "AWS"
      provider = "CodeCommit"
      version = "1"
      output_artifacts = [ 
            "source" ]
        configuration = {
          RepositoryName = var.repo-name
          BranchName = var.branch_name
        }
    }
  }

  stage {
    name = "First-build"
    action {
      category = "Build"
      name = "First-build"
      owner = "AWS"
      provider = "CodeBuild"
      version = "1"
      input_artifacts = [ "source" ]
      output_artifacts = [ "output" ]

      configuration = {
        ProjectName = aws_codebuild_project.first-build.name
      }

    }
  }
    stage {
    name = "unittest-buiold"
    action {
      category = "Build"
      name = "First-Test"
      owner = "AWS"
      provider = "CodeBuild"
      version = "1"
      input_artifacts = [ "output" ]
      output_artifacts = [ "package" ]

      configuration = {
        ProjectName = aws_codebuild_project.unittest1-codecommit-repository-test.name
      }

    }
  }
    tags =merge(
        local.common_tags,{
            Name = "${local.resource_prefix}codepipeline-test"
        }
    )   
}

output "cicd-outputs" {
    value = {
        CodeCommitRepo = {
            Data = aws_codecommit_repository.codecommit-repository-test
        }
    }
}