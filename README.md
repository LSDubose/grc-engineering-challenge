# GRC Engineering Challenge

I'm a senior GRC practitioner building an engineering skillset in public.

This is a 6-week challenge where each week adds one layer to the same system. By week 6 I'll have compliant infrastructure as code, a policy library, a CI gate, signed evidence, native cloud controls, and a control mapping an assessor can follow without scheduling a single meeting.

Most teams don't have this. I'm building it in public.

---

## The Build

| Week | Layer | Status |
|------|-------|--------|
| 1 | Compliant Resource — Terraform S3 with encryption, versioning, public access block, access logging, and auto-tagging | ✅ Complete |
| 2 | Policy as Code — executable rules that prove the controls from week 1 are in place | 🔜 |
| 3 | CI Pipeline Gate — runs on every PR, blocks any configuration that breaks a control | 🔜 |
| 4 | Signed Evidence — chain of custody on every pipeline run, keyless signing | 🔜 |
| 5 | Native Cloud Controls — monitoring controls, findings captured as evidence | 🔜 |
| 6 | OSCAL Mapping — full control mapping in machine-readable format with evidence links and portfolio case study | 🔜 |

---

## Week 1: Your First Compliant Resource

I deployed a compliant AWS S3 bucket using Terraform and verified it against real NIST 800-53 controls.

**Controls implemented:**

| Control | What it does | Resource |
|---------|-------------|----------|
| SC-28 | Encryption at rest (AES256) | `aws_s3_bucket_server_side_encryption_configuration` |
| CM-6 | Versioning enabled | `aws_s3_bucket_versioning` |
| CM-6 | Required tags enforced on every resource | `provider default_tags` |
| AC-3 | All four public access flags blocked | `aws_s3_bucket_public_access_block` |
| AU-3 | Access logging to dedicated log bucket | `aws_s3_bucket_logging` |

**Evidence:** `week-1/evidence/plan.json` — machine-readable Terraform plan capturing the configuration state of every resource before apply. This is the kind of output you attach to a control in your audit package to prove the configuration exists in production.

**Files:**
- `main.tf` — provider, buckets, and all five controls
- `variables.tf` — input variables
- `outputs.tf` — outputs including encryption algorithm attestation
- `verify.sh` — post-apply control verification script
- `terraform.tfvars.example` — copy to `terraform.tfvars` to deploy

**To run it:**
```bash
cd week-1
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan -out=tfplan
mkdir -p evidence
terraform show -json tfplan > evidence/plan.json
terraform apply "tfplan"
./verify.sh
```

---

## Why I'm doing this

GRC shouldn't be check the box. It should be the foundation that frees you to focus on strategy and real risk posture.

I wanted to shift the way I was doing things and stumbled upon the GRC Engineering Club. I learn best by doing so I'm challenging myself with the projects and building in public.

This repo is the receipts.

---

## Follow the build

- LinkedIn: [LaMeisha DuBose](https://www.linkedin.com/in/lameishadubose)
- YouTube: [LDubose](https://youtube.com/@ldubose)
- Challenge: [#GRCEngClubChallenge](https://www.linkedin.com/search/results/all/?keywords=%23GRCEngClubChallenge)
