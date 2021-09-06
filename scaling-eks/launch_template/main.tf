resource "aws_launch_template" "tuna-eks-cluster" {
  image_id = "ami-0a0de518b1fc4524c"

  instance_type = "t3.small"

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

  user_data = base64encode(templatefile("${path.module}/userdata.tpl", { 
    CLUSTER_NAME = var.tuna-eks-cluster_name, 
    B64_CLUSTER_CA = var.tuna-eks-cluster_ca, 
    API_SERVER_URL = var.tuna-eks-cluster_endpoint }))
}
