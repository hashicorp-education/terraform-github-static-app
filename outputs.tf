output "repo_url" {
  value       = github_repository.gh_repo.html_url
  description = "The URL of the created repository."
}

output "app_url" {
  value       = "https://${var.destination_org}.github.io/${var.waypoint_project}"
  description = "The URL of the app on GitHub Pages."
}