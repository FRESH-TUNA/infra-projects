resource "aws_launch_template" "logic" {
  image_id = "ami-0094965d55b3bb1ff"

  instance_type = "t2.micro"

  name = "logic"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 10
    }
  }

  credit_specification {
    cpu_credits = "standard"
  }

  key_name = var.key_name

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {}))

  network_interfaces {
    security_groups = var.logic_security_group_ids
  }
}
