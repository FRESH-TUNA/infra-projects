resource "aws_launch_template" "tuna-eks-cluster-node" {
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
      tuna-eks-cluster-node-launch_template = "test"
    }
  }
}
