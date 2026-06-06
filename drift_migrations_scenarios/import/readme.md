# Terraform Migration (Import Existing Resources)

## What is Terraform Migration?

Terraform migration means bringing existing manually created infrastructure under Terraform management without recreating the resources.

Example:

* EC2 created manually from AWS Console.
* Terraform does not know about it.
* Import the resource into Terraform state.
* Terraform can now manage it.

## Steps

### 1. Create Import Block

```hcl
import {
  to = aws_instance.example
  id = "i-1234567890abcdef"
}
```

Where:

* `to` = Terraform resource address
* `id` = Existing resource ID in AWS

### 2. Generate Terraform Configuration

```bash
terraform plan -generate-config-out=generated.tf
```

Terraform reads the existing resource and generates Terraform configuration.

Note:

* Generated configuration may contain unnecessary or conflicting attributes.
* Review and clean the generated code before using it.

### 3. Import Resource into State

```bash
terraform apply
```

or

```bash
terraform import aws_instance.example i-1234567890abcdef
```

Result:

* Resource is added to Terraform state.
* No new infrastructure is created.
* Terraform can now manage the existing resource.

## Key Interview Point

Terraform Import does NOT create resources.

It only maps existing infrastructure to Terraform state.


--------------------------------
# Terraform Drift Detection

## What is Drift?

Drift occurs when the actual infrastructure differs from the Terraform configuration.

Example:

Terraform Configuration:

```text
instance_type = t2.micro
```

Someone manually changes EC2 in AWS Console:

```text
instance_type = t2.small
```

Now:

```text
Terraform Config != Actual Infrastructure
```

This difference is called Drift.

---

## Method 1: Detect Drift using Terraform Plan

Run:

```bash
terraform plan
```

Terraform compares:

* Terraform Configuration
* Terraform State
* Actual Infrastructure

If differences exist, Terraform reports drift.

Example:

```text
~ instance_type = "t2.small" -> "t2.micro"
```

Meaning infrastructure was modified outside Terraform.

Note:

`terraform plan` automatically refreshes state before comparing.

---

## Method 2: Detect Drift using Audit Logs

### AWS

```text
CloudTrail
→ EventBridge
→ Lambda
→ SNS/Email Alert
```

### Azure

```text
Activity Logs
→ Azure Function
→ Email/Teams Alert
```

Workflow:

1. User manually changes a resource.
2. Audit logs capture the event.
3. Alert is generated.
4. DevOps team investigates.

---

## Method 3: Prevent Drift

Instead of detecting drift, prevent it.

Examples:

* Restrict AWS Console access.
* Use Read-Only permissions for developers.
* Allow infrastructure changes only through Terraform pipelines.
* Enforce GitOps workflow.

Workflow:

```text
Git Commit
→ CI/CD Pipeline
→ Terraform Apply
→ Cloud Infrastructure
```

No manual changes are allowed.

---

## Key Interview Point

Terraform drift occurs when infrastructure is modified outside Terraform.

Common solutions:

1. Terraform Plan
2. Audit Logs + Alerts
3. Restrict Manual Changes using IAM and CI/CD
