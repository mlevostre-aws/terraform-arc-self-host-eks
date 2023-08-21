data "aws_eks_cluster" "eks_cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = var.cluster_name
}

data "aws_secretsmanager_secret" "secret_github_app_private_key" {
  name = var.secret_github_app_private_key
}

data "aws_secretsmanager_secret_version" "secret_github_app_private_key" {
  secret_id = data.aws_secretsmanager_secret.secret_github_app_private_key.id
}
