terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  owner = var.destination_org
  token = var.gh_token
}

resource "github_repository" "gh_repo" {
  name       = var.waypoint_project
  visibility = "public"

  template {
    owner                = var.template_org
    repository           = var.template_repo
    include_all_branches = false
  }

  # Enable GitHub pages
  pages {
    build_type = "workflow"
  }
}

resource "github_repository_file" "readme" {
  repository = github_repository.gh_repo.name
  branch     = "main"
  file       = "README.md"
  content = templatefile("${path.module}/templates/README.md", {
    project_name    = var.waypoint_project,
    destination_org = var.destination_org
  })
  commit_message      = "Added readme file."
  commit_author       = "Platform team"
  commit_email        = "no-reply@example.com"
  overwrite_on_create = true
}

resource "github_actions_environment_secret" "slack_hook_url" {
  repository      = github_repository.gh_repo.name
  environment     = "github-pages"
  secret_name     = "SLACK_HOOK_URL"
  plaintext_value = var.slack_hook_url
}