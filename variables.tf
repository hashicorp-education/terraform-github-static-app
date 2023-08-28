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

variable "repo_suffix" {
  description = "The suffix appended to the end of the project name to create the repo name."
  default     = "_static_app"
}

variable "gh_token" {
  description = "Github token with permissions to create and delete repos."
}

variable "waypoint_project" {
  type        = string
  description = "Name of the Waypoint project."

  validation {
    condition     = !contains(["-"], var.waypoint_project)
    error_message = "waypoint_project must not contain dashes."
  }
}