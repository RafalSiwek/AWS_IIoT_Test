locals {
  common_tags={
    Terraform = true,
    Project = "tf_test"
    Owner = "RS"
  }
  resource_prefix = "rs-"
}
data "template_file" "codebuild_assume_role_policy_template" {
  template = file("${path.module}/templates/codebuild_assume_role.tpl")
}
resource "aws_iam_role" "codebuild_role" {
  name = "${local.resource_prefix}codebuild-role"
  assume_role_policy = data.template_file.codebuild_assume_role_policy_template.rendered
}
data "template_file" "codebuild_policy_template" {
  template = file("${path.module}/templates/codebuild.tpl")
  vars = {
    artifact_bucket = aws_s3_bucket.build_artifact_bucket.arn
    codebuild_project_packages = jsonencode([
      "${aws_codebuild_project.first-build.arn}",
      "${aws_codebuild_project.unittest1-codecommit-repository-test.arn}"
    ])
  }
}
resource "aws_iam_role_policy" "codebuild_policy" {
  name = "${local.resource_prefix}codebuild-policy"
  role = aws_iam_role.codebuild_role.id

  policy = data.template_file.codebuild_policy_template.rendered
}

data "template_file" "codepipeline_assume_role_policy_template" {
  template = file("${path.module}/templates/codepipeline_assume_role.tpl")
}
resource "aws_iam_role" "codepipeline_role" {
  name = "${local.resource_prefix}codepipeline-role"
  assume_role_policy = data.template_file.codepipeline_assume_role_policy_template.rendered
}
data "template_file" "codepipeline_policy_template" {
  template = file("${path.module}/templates/codepipeline.tpl")
  vars = {
    artifact_bucket = aws_s3_bucket.build_artifact_bucket.arn
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "${local.resource_prefix}codepipeline-policy"
  role = aws_iam_role.codepipeline_role.id

  policy = data.template_file.codepipeline_policy_template.rendered
}