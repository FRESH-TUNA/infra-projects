resource "aws_iam_role" "node_group" {
  name = "eks-cluster-example_node_group"

  # trust policy
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# resource "aws_iam_policy" "node_group_k8s_policy" {
#   name        = "node_group_k8s_policy"
#   description = "node_group_k8s_policy"

#   policy = file("${path.module}/node-group_k8s_policy.json")
# }

resource "aws_iam_role_policy_attachment" "amazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group.name
}

# Amazon EKS 클러스터의 포드 네트워킹을 위한 네트워킹 플러그인입니다.
resource "aws_iam_role_policy_attachment" "amazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group.name
}

# ECR 접근권한
resource "aws_iam_role_policy_attachment" "amazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group.name
}

# k8s 로드 밸런서
# resource "aws_iam_role_policy_attachment" "node_group_k8s_policy" {
#   policy_arn = aws_iam_policy.node_group_k8s_policy.arn
#   role       = aws_iam_role.node_group.name
# }
