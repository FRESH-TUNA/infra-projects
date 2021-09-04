output "sg_id" {
    value = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
}

output "oidc_provider_issuer" {
    value = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

data "tls_certificate" "example" {
  url = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

output "oidc_provider_thumbprint" {
    value = data.tls_certificate.example.certificates[0].sha1_fingerprint
}

output "tuna-eks-cluster_name" {
    value = aws_eks_cluster.cluster.name
}

output "tuna-eks-cluster_ca" {
    value = aws_eks_cluster.cluster.certificate_authority[0].data
}

output "tuna-eks-cluster_endpoint" {
    value = aws_eks_cluster.cluster.certificate_authority[0].data
}
