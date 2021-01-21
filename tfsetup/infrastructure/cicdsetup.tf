resource "aws_codecommit_repository" "codecommit-repository-test" {
    repository_name = var.repo-name
    description = "CICD test repo name"
    default_branch = "main"
    tags =merge(
    local.common_tags,
    {
      Name = var.repo-name
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