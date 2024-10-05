# Terraform Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.15.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.gatekeeper](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifact_registry"></a> [artifact\_registry](#input\_artifact\_registry) | The registry to pull the images from | `string` | `"us-docker.pkg.dev/plt-lz-services-tf79-prod/plt-docker-virtual"` | no |
| <a name="input_chart_repository"></a> [chart\_repository](#input\_chart\_repository) | The repository to pull the Helm chart from | `string` | `"https://open-policy-agent.github.io/gatekeeper/charts"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment must be one of `sandbox`, `non-production`, `production` | `string` | `"sandbox"` | no |
| <a name="input_gatekeeper_version"></a> [gatekeeper\_version](#input\_gatekeeper\_version) | The version to install, this is used for the chart as well as the image tag | `string` | `"v3.17.1"` | no |
| <a name="input_node_location"></a> [node\_location](#input\_node\_location) | The zone in which the cluster's nodes should be located. If not specified, the cluster's nodes are located across zones in the region | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The region in which the resource belongs | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
