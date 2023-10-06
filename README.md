# GitHub static app module

This module creates a GitHub repository from a template repository (defined in [variables.tf](variables.tf) with `template_org` and `template_repo`), enables GitHub Pages on it, adds a readme file from a [template](templates/README.md), and adds a GitHub Action secret for a Slack Webhook URL.

It is a companion repository to the [HCP Waypoint get started collection](https://developer.hashicorp.com/waypoint/tutorials/hcp-waypoint).
