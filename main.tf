# Set terraform and provider version
terraform {
  required_version = ">= 1.0.11"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}

locals {
  role_name             = format("rol-etrz-%s-desc", var.m_environment_tag)
  instance_profile_name = format("instanceprofile-%s-%s", var.m_app_name, var.m_iam_role_label)
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = var.m_trusted_role_actions

    principals {
      type        = "AWS"
      identifiers = var.m_trusted_role_arns
    }

    principals {
      type        = "Service"
      identifiers = var.m_trusted_role_services
    }
  }
}

resource "aws_iam_role" "main" {
  name                 = local.role_name
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json
  max_session_duration = var.m_max_session_duration
  managed_policy_arns  = var.m_managed_policy_arns
}

resource "aws_iam_instance_profile" "default" {
  count = var.m_instance_profile_enabled ? 1 : 0
  role  = aws_iam_role.main.name
  name  = local.instance_profile_name
}

resource "aws_iam_role_policy_attachment" "custom" {
  count = length(var.m_custom_role_policy_arns)

  role       = aws_iam_role.main.name
  policy_arn = element(var.m_custom_role_policy_arns, count.index)
}
