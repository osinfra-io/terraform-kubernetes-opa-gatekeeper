# Input Variables
# https://www.terraform.io/language/values/variables

variable "artifact_registry" {
  description = "The registry to pull the images from"
  type        = string
  default     = "us-docker.pkg.dev/plt-lz-services-tf79-prod/plt-docker-virtual"
}

variable "chart_repository" {
  description = "The repository to pull the Helm chart from"
  type        = string
  default     = "https://open-policy-agent.github.io/gatekeeper/charts"
}

variable "environment" {
  description = "The environment must be one of `sandbox`, `non-production`, `production`"
  type        = string
  default     = "sandbox"

  validation {
    condition     = contains(["mock-environment", "sandbox", "non-production", "production"], var.environment)
    error_message = "The environment must be one of `mock-environment` for tests or `sandbox`, `non-production`, or `production`."
  }
}

variable "gatekeeper_version" {
  description = "The version to install, this is used for the chart as well as the image tag"
  type        = string
  default     = "v3.17.1"
}

variable "node_location" {
  description = "The zone in which the cluster's nodes should be located. If not specified, the cluster's nodes are located across zones in the region"
  type        = string
  default     = null
}

variable "region" {
  description = "The region in which the resource belongs"
  type        = string
}
