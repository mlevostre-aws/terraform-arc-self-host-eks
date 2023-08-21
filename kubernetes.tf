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
          organization = "mlevos-demo"
          labels       = ["aws"]
        }
      }
    }
  }
}

resource "kubernetes_service_account" "github_service_account" {
  metadata {
    namespace = var.github_namespace_name
    name      = "github-action"
  }
}