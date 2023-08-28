output "repo_url" {
  value       = github_repository.gh_repo.html_url
  description = "The URL of the created repository."
}