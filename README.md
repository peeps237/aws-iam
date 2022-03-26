# aws-iam

Provide IAM role with the specific parameters for GrtGaz system team account:

For EC2 role, instance profile can be created by passing parameter :
```
m_instance_profile_enabled = true
```



---

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0.0 |

---

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_m_app_name"></a> [m\_app\_name](#input\_m\_app\_name) | The name of the application which requires this module-specific service | `string` | n/a | yes |
| <a name="input_m_custom_role_policy_arns"></a> [m\_custom\_role\_policy\_arns](#input\_m\_custom\_role\_policy\_arns) | Set of exclusive IAM custom policy ARNs to attach to the IAM role. | `list(string)` | `[]` | no |
| <a name="input_m_environment_tag"></a> [m\_environment\_tag](#input\_m\_environment\_tag) | The environment name to be used while tagging the provisioned resources. The list of possible values are as follows:<br>- `dev` for development environment<br>- `stg` for staging or pre-production environment<br>- `prd` for production environment<br><br>Defaults to `dev` (for development environment) if no value is specified. | `string` | `"dev"` | no |
| <a name="input_m_iam_role_label"></a> [m\_iam\_role\_label](#input\_m\_iam\_role\_label) | Role short label | `string` | n/a | yes |
| <a name="input_m_instance_profile_enabled"></a> [m\_instance\_profile\_enabled](#input\_m\_instance\_profile\_enabled) | Create EC2 Instance Profile for the role | `bool` | `false` | no |
| <a name="input_m_managed_policy_arns"></a> [m\_managed\_policy\_arns](#input\_m\_managed\_policy\_arns) | Set of exclusive IAM managed policy ARNs to attach to the IAM role. | `set(string)` | `[]` | no |
| <a name="input_m_max_session_duration"></a> [m\_max\_session\_duration](#input\_m\_max\_session\_duration) | The maximum session duration (in seconds) for the role. Can have a value from 1 hour to 12 hours | `number` | `3600` | no |
| <a name="input_m_trusted_role_actions"></a> [m\_trusted\_role\_actions](#input\_m\_trusted\_role\_actions) | The IAM action to be granted by the AssumeRole policy | `list(string)` | <pre>[<br>  "sts:AssumeRole"<br>]</pre> | no |
| <a name="input_m_trusted_role_arns"></a> [m\_trusted\_role\_arns](#input\_m\_trusted\_role\_arns) | ARNs of AWS entities who can assume these roles | `list(string)` | `[]` | no |
| <a name="input_m_trusted_role_services"></a> [m\_trusted\_role\_services](#input\_m\_trusted\_role\_services) | AWS Services that can assume these roles | `list(string)` | `[]` | no |

---

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_instance_profile"></a> [iam\_instance\_profile](#output\_iam\_instance\_profile) | Name of the ec2 profile (if enabled) |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The ARN of the IAM Role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of the IAM Role |

---

## Examples

```hcl
module "iam_role" {
  source = "..//"

  m_app_name        = "etr-sam"
  m_environment_tag = "development"

  m_iam_role_label = "test"
  m_managed_policy_arns = [
    "arn:aws:iam::aws:policy/AWSDirectConnectReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
  m_trusted_role_services    = ["ec2.amazonaws.com"]
  m_instance_profile_enabled = true
  m_custom_role_policy_arns  = ["arn:aws:iam::811435742717:policy/test-attach"]

  m_tags = {
    AppDomain   = "iam"
    Owner       = "TFProviders"
    Environment = "Development"
    Project     = "etr-sam"
  }
}
```
