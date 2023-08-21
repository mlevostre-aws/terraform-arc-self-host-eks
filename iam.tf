module "vpc_cni_irsa_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "github-action-role"

  oidc_providers = {
    main = {
      provider_arn               = data.aws_iam_openid_connect_provider.oidc.arn
      namespace_service_accounts = ["${var.github_namespace_name}:${kubernetes_service_account.github_service_account.metadata.0.name}"]
    }
  }
}