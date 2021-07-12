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

  # vpc_security_group_ids = var.vpc_security_group_ids

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh", 
  { ALLOCATION_ID = var.eip_allocation_id }))

  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.vpc_security_group_ids
  }

  iam_instance_profile {
    name = var.instance_profile_name
  }
}
