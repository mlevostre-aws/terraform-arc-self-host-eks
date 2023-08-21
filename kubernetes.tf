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
          organization = "mlevos-demo"
          labels       = ["aws"]
        }
      }
    }
  }
}