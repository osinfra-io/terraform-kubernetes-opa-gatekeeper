# Helm Release
# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

resource "helm_release" "gatekeeper" {
  chart      = "gatekeeper"
  name       = "gatekeeper"
  namespace  = "gatekeeper-system"
  repository = var.chart_repository

  set {
    name  = "audit.resources.limits.cpu"
    value = var.audit_resources_limits_cpu
  }

  set {
    name  = "audit.resources.limits.memory"
    value = var.audit_resources_limits_memory
  }

  set {
    name  = "audit.resources.requests.cpu"
    value = var.audit_resources_requests_cpu
  }

  set {
    name  = "audit.resources.requests.memory"
    value = var.audit_resources_requests_memory
  }

  set {
    name  = "controllerManager.resources.limits.cpu"
    value = var.controller_manager_resources_limits_cpu
  }

  set {
    name  = "controllerManager.resources.limits.memory"
    value = var.controller_manager_resources_limits_memory
  }

  set {
    name  = "controllerManager.resources.requests.cpu"
    value = var.controller_manager_resources_requests_cpu
  }

  set {
    name  = "controllerManager.resources.requests.memory"
    value = var.controller_manager_resources_requests_memory
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
    value = var.replicas
  }

  values = [
    file("${path.module}/helm/gatekeeper.yml")
  ]

  version = var.gatekeeper_version
}

# Kubernetes Manifest Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest

resource "kubernetes_manifest" "opa_gatekeeper_ca_certificate" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Certificate"

    metadata = {
      labels = {
        "gatekeeper.sh/system" = "yes"
      }

      name      = "gatekeeper-ca"
      namespace = "gatekeeper-system"
    }

    spec = {
      commonName = "gatekeeper-ca.osinfra.io"
      duration   = "2160h"
      isCA       = true

      issuerRef = {
        name  = "selfsigned"
        kind  = "Issuer"
        group = "cert-manager.io"
      }

      secretName = "gatekeeper-ca"

      subject = {
        organizations = ["gatekeeper.osinfra.io"]
      }
    }
  }
}

resource "kubernetes_manifest" "opa_gatekeeper_ca_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Issuer"

    metadata = {
      labels = {
        "gatekeeper.sh/system" = "yes"
      }

      name      = "gatekeeper-ca"
      namespace = "gatekeeper-system"
    }

    spec = {
      ca = {
        secretName = "gatekeeper-ca"
      }
    }
  }
}

resource "kubernetes_manifest" "opa_gatekeeper_selfsigned_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Issuer"

    metadata = {
      labels = {
        "gatekeeper.sh/system" = "yes"
      }

      name      = "selfsigned"
      namespace = "gatekeeper-system"
    }

    spec = {
      selfSigned = {}
    }
  }
}

resource "kubernetes_manifest" "opa_gatekeeper_server_cert" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Certificate"

    metadata = {
      labels = {
        "gatekeeper.sh/system" = "yes"
      }

      name      = "gatekeeper-webhook-server-cert"
      namespace = "gatekeeper-system"
    }

    spec = {
      commonName = "gatekeeper-webhook-service.osinfra.io"

      dnsNames = [
        "gatekeeper-webhook-service",
        "gatekeeper-webhook-service.gatekeeper-system",
        "gatekeeper-webhook-service.gatekeeper-system.svc"
      ]

      duration = "2160h"
      isCA     = false

      issuerRef = {
        name  = "gatekeeper-ca"
        kind  = "Issuer"
        group = "cert-manager.io"
      }

      renewBefore = "360h"
      secretName  = "gatekeeper-webhook-server-cert"

      usages = [
        "client auth",
        #"digital signature",
        #"key encipherment",
        "server auth"
      ]
    }
  }
}
