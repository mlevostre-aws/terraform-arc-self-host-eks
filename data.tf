data "aws_eks_cluster" "eks_cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = var.cluster_name
}


data "aws_iam_openid_connect_provider" "oidc" {
  url = data.aws_eks_cluster.eks_cluster.issuer
}