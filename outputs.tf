output "repo_url" {
  value       = github_repository.gh_repo.html_url
  description = "The URL of the created repository."
}

output "app_url" {
  value       = "https://${var.destination_org}.github.io/${var.waypoint_project}"
  description = "The URL of the app on GitHub Pages."
}

output "route_53_nameservers" {
  value       = aws_route53_zone.domain.name_servers
  description = "The name servers for the hosted zone."
}

output "app_subdomain_url" {
  value       = "http://${var.waypoint_project}.${var.domain}"
  description = "The subdomain URL for the app."
}