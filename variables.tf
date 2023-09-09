variable "template_org" {
  description = "The name of the organization in Github that will contain the example app repo."
  default     = "tunzor"
}

variable "template_repo" {
  description = "The name of the repository in Github that contains the example app code."
  default     = "2048-template"
}

variable "destination_org" {
  description = "The name of the organization in Github that will contain the templated repo."
  default     = "hashicorp-education"
}

variable "gh_token" {
  description = "Github token with permissions to create and delete repos."
}

variable "slack_hook_url" {
  description = "The Slack webhook URL for publishing messages."
}

variable "waypoint_project" {
  type        = string
  description = "Name of the Waypoint project."

  validation {
    condition     = !contains(["-", "_"], var.waypoint_project)
    error_message = "waypoint_project must not contain dashes or underscores."
  }
}