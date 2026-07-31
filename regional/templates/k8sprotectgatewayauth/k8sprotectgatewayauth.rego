package k8sprotectgatewayauth

# Platform break-glass group permitted to manage gateway authn/authz resources.
allowed_principal if {
	"system:masters" in input.review.userInfo.groups
}

# Gatekeeper audit reviews carry no userInfo (there is no requesting actor), so the identity of the
# change cannot be evaluated. Treat those reviews as allowed to avoid reporting every pre-existing
# protected resource as a false-positive violation; admission requests always populate userInfo.
allowed_principal if {
	not input.review.userInfo
}

# Istio authn/authz resources that only platform principals may manage.
protected_kinds := {
	{"group": "networking.istio.io", "kind": "EnvoyFilter"},
	{"group": "security.istio.io", "kind": "AuthorizationPolicy"},
	{"group": "security.istio.io", "kind": "RequestAuthentication"},
}

# Namespaces whose lifecycle and Secrets are platform-managed.
protected_namespaces := {"authentik"}

review_object := object.get(input.review, "object", object.get(input.review, "oldObject", {}))

violation contains {"msg": msg} if {
	not allowed_principal
	{"group": input.review.kind.group, "kind": input.review.kind.kind} in protected_kinds
	msg := sprintf("gateway authn/authz resource %s/%s is platform-managed and may only be changed by platform principals", [input.review.kind.group, input.review.kind.kind])
}

violation contains {"msg": msg} if {
	not allowed_principal
	input.review.kind.kind == "Namespace"
	review_object.metadata.name in protected_namespaces
	msg := sprintf("namespace %q is platform-managed and may only be changed by platform principals", [review_object.metadata.name])
}

violation contains {"msg": msg} if {
	not allowed_principal
	input.review.kind.kind == "Secret"
	object.get(review_object.metadata, "namespace", "") in protected_namespaces
	msg := sprintf("secrets in platform-managed namespace %q may only be changed by platform principals", [object.get(review_object.metadata, "namespace", "")])
}
