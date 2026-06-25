# METADATA
# title: CM-6 - Configuration Settings (AWS required tags)
# description: Taggable resources must carry the four required compliance tags.
# custom:
#   control_id: CM-6
#   framework: nist-800-53
#   severity: medium
#   remediation: Add the missing tags or rely on provider default_tags.
package compliance.cm6_aws

import rego.v1

required := {"Project", "Environment", "ManagedBy", "ComplianceScope"}

deny contains msg if {
	resource := input.planned_values.root_module.resources[_]
	tags := resource.values.tags_all
	missing := required - {k | tags[k]}
	count(missing) > 0
	msg := sprintf("CM-6: %s is missing required tags: %v", [resource.address, missing])
}