package k8sprotectgatewayauth_test

import data.k8sprotectgatewayauth

test_protected_istio_kind_denied if {
	some result in k8sprotectgatewayauth.violation with input as {"review": {
		"kind": {"group": "security.istio.io", "kind": "AuthorizationPolicy"},
		"object": {"metadata": {"name": "deny-all"}},
		"userInfo": {"groups": ["system:authenticated"]},
	}}
	result.msg == "gateway authn/authz resource security.istio.io/AuthorizationPolicy is platform-managed and may only be changed by platform principals"
}

test_platform_principal_allowed if {
	count(k8sprotectgatewayauth.violation) == 0 with input as {"review": {
		"kind": {"group": "security.istio.io", "kind": "AuthorizationPolicy"},
		"object": {"metadata": {"name": "deny-all"}},
		"userInfo": {"groups": ["system:masters"]},
	}}
}

test_protected_namespace_denied if {
	some result in k8sprotectgatewayauth.violation with input as {"review": {
		"kind": {"group": "", "kind": "Namespace"},
		"object": {"metadata": {"name": "authentik"}},
		"userInfo": {"groups": ["system:authenticated"]},
	}}
	result.msg == "namespace \"authentik\" is platform-managed and may only be changed by platform principals"
}

test_protected_secret_denied if {
	some result in k8sprotectgatewayauth.violation with input as {"review": {
		"kind": {"group": "", "kind": "Secret"},
		"object": {"metadata": {"name": "oidc", "namespace": "authentik"}},
		"userInfo": {"groups": ["system:authenticated"]},
	}}
	result.msg == "secrets in platform-managed namespace \"authentik\" may only be changed by platform principals"
}

test_unprotected_kind_allowed if {
	count(k8sprotectgatewayauth.violation) == 0 with input as {"review": {
		"kind": {"group": "apps", "kind": "Deployment"},
		"object": {"metadata": {"name": "web", "namespace": "team-a"}},
		"userInfo": {"groups": ["system:authenticated"]},
	}}
}
