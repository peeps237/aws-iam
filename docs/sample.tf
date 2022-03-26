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