module "github_action_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "github-action-role"

  role_policy_arns = {
    policy = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  }

  oidc_providers = {
    main = {
      provider_arn               = data.aws_iam_openid_connect_provider.oidc.arn
      namespace_service_accounts = ["${var.github_namespace_name}:${local.github_service_account_name}"]
    }
  }
}


 