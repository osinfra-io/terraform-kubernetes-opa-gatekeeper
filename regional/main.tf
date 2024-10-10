# Helm Release
# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

resource "helm_release" "gatekeeper" {
  chart      = "gatekeeper"
  name       = "gatekeeper"
  namespace  = "gatekeeper-system"
  repository = var.chart_repository

  set {
    name  = "audit.resources.limits.cpu"
    value = "40m"
  }

  set {
    name  = "audit.resources.limits.memory"
    value = "128Mi"
  }

  set {
    name  = "audit.resources.requests.cpu"
    value = "10m"
  }

  set {
    name  = "audit.resources.requests.memory"
    value = "32Mi"
  }

  set {
    name  = "controllerManager.resources.limits.cpu"
    value = "100m"
  }

  set {
    name  = "controllerManager.resources.limits.memory"
    value = "256Mi"
  }

  set {
    name  = "controllerManager.resources.requests.cpu"
    value = "10m"
  }

  set {
    name  = "controllerManager.resources.requests.memory"
    value = "32Mi"
  }

  set {
    name  = "image.crdRepository"
    value = "${var.artifact_registry}/openpolicyagent/gatekeeper-crds"
  }

  set {
    name  = "image.repository"
    value = "${var.artifact_registry}/openpolicyagent/gatekeeper"
  }

  set {
    name  = "image.release"
    value = var.gatekeeper_version
  }

  set {
    name  = "podLabels.tags\\.datadoghq\\.com/env"
    value = var.environment
  }

  set {
    name  = "podLabels.tags\\.datadoghq\\.com/version"
    value = var.gatekeeper_version
  }

  set {
    name  = "postInstall.labelNamespace.image.repository"
    value = "${var.artifact_registry}/openpolicyagent/gatekeeper-crds"
  }

  set {
    name  = "postInstall.labelNamespace.image.tag"
    value = var.gatekeeper_version
  }

  set {
    name  = "preInstall.crdRepository.image.tag"
    value = var.gatekeeper_version
  }

  set {
    name  = "replicas"
    value = 1
  }

  values = [
    file("${path.module}/helm/gatekeeper.yml")
  ]

  version = var.gatekeeper_version
}
