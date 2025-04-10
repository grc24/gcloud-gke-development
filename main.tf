resource "github_repository" "main" {
  name               = var.repository_name
  description        = "Terraform create repository for Google GKE"
  visibility         = "public"
  auto_init          = true
  gitignore_template = "Terraform"
}

resource "github_branch" "main" {
  repository = github_repository.main.name
  branch     = "main"
}

resource "github_branch_default" "main" {
  repository = github_repository.main.name
  branch     = github_branch.main.branch
}