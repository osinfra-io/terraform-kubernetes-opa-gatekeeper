# Terraform Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.16.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.33.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.gatekeeper](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.opa_gatekeeper_ca_certificate](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.opa_gatekeeper_ca_issuer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.opa_gatekeeper_selfsigned_issuer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.opa_gatekeeper_server_cert](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifact_registry"></a> [artifact\_registry](#input\_artifact\_registry) | The registry to pull the images from | `string` | `"us-docker.pkg.dev/plt-lz-services-tf79-prod/plt-docker-virtual"` | no |
| <a name="input_audit_resources_limits_cpu"></a> [audit\_resources\_limits\_cpu](#input\_audit\_resources\_limits\_cpu) | The CPU limit for the audit container | `string` | `"40m"` | no |
| <a name="input_audit_resources_limits_memory"></a> [audit\_resources\_limits\_memory](#input\_audit\_resources\_limits\_memory) | The memory limit for the audit container | `string` | `"128Mi"` | no |
| <a name="input_audit_resources_requests_cpu"></a> [audit\_resources\_requests\_cpu](#input\_audit\_resources\_requests\_cpu) | The CPU request for the audit container | `string` | `"10m"` | no |
| <a name="input_audit_resources_requests_memory"></a> [audit\_resources\_requests\_memory](#input\_audit\_resources\_requests\_memory) | The memory request for the audit container | `string` | `"32Mi"` | no |
| <a name="input_chart_repository"></a> [chart\_repository](#input\_chart\_repository) | The repository to pull the Helm chart from | `string` | `"https://open-policy-agent.github.io/gatekeeper/charts"` | no |
| <a name="input_controller_manager_resources_limits_cpu"></a> [controller\_manager\_resources\_limits\_cpu](#input\_controller\_manager\_resources\_limits\_cpu) | The CPU limit for the controller manager container | `string` | `"100m"` | no |
| <a name="input_controller_manager_resources_limits_memory"></a> [controller\_manager\_resources\_limits\_memory](#input\_controller\_manager\_resources\_limits\_memory) | The memory limit for the controller manager container | `string` | `"256Mi"` | no |
| <a name="input_controller_manager_resources_requests_cpu"></a> [controller\_manager\_resources\_requests\_cpu](#input\_controller\_manager\_resources\_requests\_cpu) | The CPU request for the controller manager container | `string` | `"10m"` | no |
| <a name="input_controller_manager_resources_requests_memory"></a> [controller\_manager\_resources\_requests\_memory](#input\_controller\_manager\_resources\_requests\_memory) | The memory request for the controller manager container | `string` | `"32Mi"` | no |
| <a name="input_gatekeeper_version"></a> [gatekeeper\_version](#input\_gatekeeper\_version) | The version to install, this is used for the chart as well as the image tag | `string` | `"v3.17.1"` | no |
| <a name="input_node_location"></a> [node\_location](#input\_node\_location) | The zone in which the cluster's nodes should be located. If not specified, the cluster's nodes are located across zones in the region | `string` | `null` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | The number of replicas to run | `number` | `1` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
