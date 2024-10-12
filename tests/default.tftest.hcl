# Terraform Tests
# https://developer.hashicorp.com/terraform/language/tests

# Terraform Mock Providers
# https://developer.hashicorp.com/terraform/language/tests/mocking

mock_provider "google" {}
mock_provider "helm" {}
mock_provider "kubernetes" {}
mock_provider "terraform" {}

run "default_regional" {
  command = apply

  module {
    source = "./tests/fixtures/default/regional"
  }

  variables {
    region                      = "mock-region-a"
  }
}

run "default_regional_manifests" {
  command = apply

  module {
    source = "./tests/fixtures/default/regional/manifests"
  }
}

variables {
  environment = "mock-environment"
}
