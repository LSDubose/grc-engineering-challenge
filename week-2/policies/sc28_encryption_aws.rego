# METADATA
# title: SC-28 - Encryption at Rest (AWS S3)
# description: Every aws_s3_bucket must have a matching server-side encryption configuration.
# custom:
#   control_id: SC-28
#   framework: nist-800-53
#   severity: high
#   remediation: Add aws_s3_bucket_server_side_encryption_configuration referencing the bucket.
package compliance.sc28_aws

import rego.v1

any_encryption_exists(ref) if {
	r := input.configuration.root_module.resources[_]
	r.type == "aws_s3_bucket_server_side_encryption_configuration"
	ref in r.expressions.bucket.references
}

deny contains msg if {
	bucket := input.configuration.root_module.resources[_]
	bucket.type == "aws_s3_bucket"
	ref := sprintf("%s.%s.id", [bucket.type, bucket.name])
	not any_encryption_exists(ref)
	msg := sprintf("SC-28: aws_s3_bucket.%s has no encryption configuration", [bucket.name])
}