terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
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
    destination_org = var.destination_org,
    domain          = var.domain
  })
  commit_message      = "Added readme file."
  commit_author       = "Platform team"
  commit_email        = "no-reply@example.com"
  overwrite_on_create = true
}

resource "github_repository_file" "workflow_trigger_file" {
  repository          = github_repository.gh_repo.name
  branch              = "main"
  file                = "app/trigger"
  content             = ""
  commit_message      = "Added file to trigger workflow."
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

# Add-on to create subdomain for the app
resource "aws_route53_zone" "domain" {
  name = var.domain
}

resource "aws_s3_bucket" "redirect" {
  bucket = "${var.waypoint_project}.${var.domain}"
}

resource "aws_s3_bucket_website_configuration" "redirect" {
  bucket = "${var.waypoint_project}.${var.domain}"

  redirect_all_requests_to {
    host_name = "${var.destination_org}.github.io/${var.waypoint_project}"
  }
}

resource "aws_route53_record" "subdomain" {
  name    = "${var.waypoint_project}.${var.domain}"
  zone_id = aws_route53_zone.domain.zone_id
  type    = "A"

  alias {
    name                   = aws_s3_bucket_website_configuration.redirect.website_domain
    zone_id                = aws_s3_bucket.redirect.hosted_zone_id
    evaluate_target_health = true
  }
}