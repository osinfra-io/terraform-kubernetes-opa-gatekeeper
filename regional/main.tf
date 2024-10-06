# Helm Release
# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

resource "helm_release" "gatekeeper" {
  chart      = "gatekeeper"
  name       = "gatekeeper"
  namespace  = "gatekeeper-system"
  repository = var.chart_repository

  set {
    name  = "podLabels.tags\\.datadoghq\\.com/env"
    value = var.environment
  }

  set {
    name  = "podLabels.tags\\.datadoghq\\.com/version"
    value = var.gatekeeper_version
  }

  # set {
  #   name  = "podLabels.tags\\.datadoghq\\.com/service"
  #   value = "gatekeeper"
  # }

  values = [
    file("${path.module}/helm/gatekeeper.yml")
  ]

  version = var.gatekeeper_version
}
