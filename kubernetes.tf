resource "kubernetes_namespace" "github" {
  metadata {
    name = "github"
  }
}

resource "kubernetes_manifest" "self_host_github_runner" {
  manifest = {
    apiVersion = "actions.summerwind.dev/v1alpha1"
    kind       = "RunnerDeployment"
    metadata = {
      name      = "aws-self-host"
      namespace = kubernetes_namespace.github.metadata.0.name
    }
    spec = {
      replicas = 1
      template = {
        spec = {
          organization = "mlevos-demo"
          labels       = ["aws"]
        }
      }
    }
  }
  depends_on = [helm_release.gihtub_action]
}