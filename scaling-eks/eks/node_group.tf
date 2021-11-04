resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "node_group"
  node_role_arn   = var.node_group_role_arn
  subnet_ids      = var.node_group_subnets
  
  # 최소 t3.small 로 진행
  instance_types = ["t3.small"]

  # $LATEST나 $DEFAULT 버전 사용 가능
  launch_template {
    id = var.tuna-eks-cluster-node-launch_template_id
    version = "1"
  }

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    var.node_group_attachment_1,
    var.node_group_attachment_2,
    var.node_group_attachment_3
  ]
}
