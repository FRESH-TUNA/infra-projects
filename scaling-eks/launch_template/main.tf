resource "aws_launch_template" "tuna-eks-cluster" {
  image_id = "ami-065032e477e2adb5e"

  # default_version = 2

  # anti pattern
  # instance_type = "t3.small"

  name = "tuna-eks-cluster-node-launch_template"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 10
    }
  }

  credit_specification {
    cpu_credits = "standard"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      "k8s.io/cluster-autoscaler/enabled" = "TRUE"
      "k8s.io/cluster-autoscaler/${var.tuna-eks-cluster_name}" = "owned"
    }
  }

  # launch template update 시 항상 node가 먼저 생성되도록 하는것 같다.
  lifecycle {
    create_before_destroy = true
  }

  user_data = base64encode(templatefile("${path.module}/userdata.tpl", { 
    CLUSTER_NAME = var.tuna-eks-cluster_name, 
    B64_CLUSTER_CA = var.tuna-eks-cluster_ca, 
    API_SERVER_URL = var.tuna-eks-cluster_endpoint }))
}
