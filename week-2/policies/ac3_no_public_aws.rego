# METADATA
# title: AC-3 - Access Enforcement (AWS S3 public access block)
# description: Every aws_s3_bucket must have a public access block with all four flags true.
# custom:
#   control_id: AC-3
#   framework: nist-800-53
#   severity: critical
#   remediation: Add aws_s3_bucket_public_access_block referencing the bucket, all four flags true.
package compliance.ac3_aws

import rego.v1

any_pab_exists(ref) if {
	r := input.configuration.root_module.resources[_]
	r.type == "aws_s3_bucket_public_access_block"
	ref in r.expressions.bucket.references
}

deny contains msg if {
	bucket := input.configuration.root_module.resources[_]
	bucket.type == "aws_s3_bucket"
	ref := sprintf("%s.%s.id", [bucket.type, bucket.name])
	not any_pab_exists(ref)
	msg := sprintf("AC-3: aws_s3_bucket.%s has no public access block", [bucket.name])
}
