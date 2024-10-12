# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  env = lookup(local.env_map, local.environment, "none")

  environment = (
    terraform.workspace == "default" ?
    "mock-environment" :
    (regex(".*-(?P<environment>[^-]+)$", terraform.workspace)["environment"])
  )

  env_map = {
    "non-production" = "nonprod"
    "production"     = "prod"
    "sandbox"        = "sb"
  }

  helm_values = {
    "audit.resources.limits.cpu"                  = var.audit_resources_limits_cpu
    "audit.resources.limits.memory"               = var.audit_resources_limits_memory
    "audit.resources.requests.cpu"                = var.audit_resources_requests_cpu
    "audit.resources.requests.memory"             = var.audit_resources_requests_memory
    "controllerManager.resources.limits.cpu"      = var.controller_manager_resources_limits_cpu
    "controllerManager.resources.limits.memory"   = var.controller_manager_resources_limits_memory
    "controllerManager.resources.requests.cpu"    = var.controller_manager_resources_requests_cpu
    "controllerManager.resources.requests.memory" = var.controller_manager_resources_requests_memory
    "image.crdRepository"                         = "${var.artifact_registry}/openpolicyagent/gatekeeper-crds"
    "image.repository"                            = "${var.artifact_registry}/openpolicyagent/gatekeeper"
    "image.release"                               = var.gatekeeper_version
    "podLabels.tags\\.datadoghq\\.com/env"        = local.environment
    "podLabels.tags\\.datadoghq\\.com/version"    = var.gatekeeper_version
    "postInstall.labelNamespace.image.repository" = "${var.artifact_registry}/openpolicyagent/gatekeeper-crds"
    "postInstall.labelNamespace.image.tag"        = var.gatekeeper_version
    "preInstall.crdRepository.image.tag"          = var.gatekeeper_version
    "replicas"                                    = var.replicas
  }
}
