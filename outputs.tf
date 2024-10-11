output "repo_url" {
  value       = github_repository.gh_repo.html_url
  description = "The URL of the created repository."
}

output "app_url" {
  value       = "https://${var.destination_org}.github.io/${var.waypoint_application}"
  description = "The URL of the app on GitHub Pages."
}

output "repo_name" {
  value = github_repository.gh_repo.full_name
}
