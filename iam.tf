module "github_action_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "github-action-role"

  oidc_providers = {
    main = {
      provider_arn               = data.aws_iam_openid_connect_provider.oidc.arn
      namespace_service_accounts = ["${var.github_namespace_name}:${local.github_service_account_name}"]
    }
  }
}
resource "aws_iam_role_policy_attachment" "github_action_attach" {
  role       = module.github_action_role.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
}

 