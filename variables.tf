variable "m_app_name" {
  type        = string
  description = "The name of the application which requires this module-specific service"
}

variable "m_instance_profile_enabled" {
  type        = bool
  default     = false
  description = "Create EC2 Instance Profile for the role"
}

variable "m_iam_role_label" {
  type        = string
  description = "Role short label"
}

variable "m_trusted_role_actions" {
  type        = list(string)
  description = "The IAM action to be granted by the AssumeRole policy"
  default     = ["sts:AssumeRole"]
}

variable "m_trusted_role_arns" {
  description = "ARNs of AWS entities who can assume these roles"
  type        = list(string)
  default     = []
}

variable "m_trusted_role_services" {
  description = "AWS Services that can assume these roles"
  type        = list(string)
  default     = []
}

variable "m_managed_policy_arns" {
  type        = set(string)
  description = "Set of exclusive IAM managed policy ARNs to attach to the IAM role."
  default     = []
}

variable "m_custom_role_policy_arns" {
  type        = list(string)
  description = "Set of exclusive IAM custom policy ARNs to attach to the IAM role."
  default     = []
}

variable "m_max_session_duration" {
  type        = number
  default     = 3600
  description = "The maximum session duration (in seconds) for the role. Can have a value from 1 hour to 12 hours"
}

variable "m_environment_tag" {
  type        = string
  description = <<-EOF
  The environment name to be used while tagging the provisioned resources. The list of possible values are as follows:
  - `dev` for development environment
  - `stg` for staging or pre-production environment
  - `prd` for production environment

  Defaults to `dev` (for development environment) if no value is specified.
EOF
  default     = "dev"

  validation {
    condition     = contains(["dev", "stg", "prd"], lower(var.m_environment_tag))
    error_message = "Unsupported environment tag specified. Supported environments are: 'dev', 'stg', and 'prd'."
  }
}
