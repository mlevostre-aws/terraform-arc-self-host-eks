resource "kubernetes_manifest" "self_host_github_runner" {
  manifest = {
    apiVersion = "actions.summerwind.dev/v1alpha1"
    kind       = "RunnerDeployment"
    metadata = {
      name      = "aws-self-host"
      namespace = var.github_namespace_name

    }
    spec = {
      replicas = 1
      template = {
        spec = {
          serviceAccountName = kubernetes_service_account.github_service_account.metadata.0.name
          organization       = "mlevos-demo"
          labels             = ["aws"]
          containers = [
            {
              name            = "aws"
              image           = "amazon/aws-cli:2.13.11"
              imagePullPolicy = "Always"
            }
          ]
        }
      }
    }
  }
}

resource "kubernetes_service_account" "github_service_account" {
  metadata {
    namespace = var.github_namespace_name
    name      = local.github_service_account_name
    annotations = {
      "eks.amazonaws.com/role-arn" = module.github_action_role.iam_role_arn
    }
  }
}
