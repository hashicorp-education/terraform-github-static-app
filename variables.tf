variable "template_org" {
  description = "The name of the organization in Github that will contain the example app repo."
  default     = "hashicorp-education"
}

variable "template_repo" {
  description = "The name of the repository in Github that contains the example app code."
  default     = "learn-hcp-waypoint-static-app-template"
}

variable "destination_org" {
  description = "The name of the organization in Github that will contain the templated repo."
  default     = "hashicorp-education"
}

variable "gh_token" {
  description = "Github token with permissions to create and delete repos."
  sensitive   = true
}

variable "slack_hook_url" {
  description = "The Slack webhook URL for publishing messages."
  default     = ""
}

variable "waypoint_application" {
  type        = string
  description = "Name of the Waypoint application."

  validation {
    condition     = !contains(["-", "_"], var.waypoint_application)
    error_message = "waypoint_application must not contain dashes or underscores."
  }
}
