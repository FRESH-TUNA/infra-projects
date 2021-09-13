resource "aws_launch_template" "logic" {
  image_id = "ami-0094965d55b3bb1ff"

  instance_type = "t2.micro"

  name = "real_logic"

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
      Name = "test"
    }
  }

  user_data = base64encode(templatefile("${path.module}/user_data.tpl", {}))

  network_interfaces {
    security_groups = var.logic_security_group_ids
  }
}


resource "aws_launch_template" "nat" {
  image_id = "ami-07e3822d44637d67c"

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

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

  # network_interfaces {
  #   security_groups = var.nat_security_group_ids
  # }
}
