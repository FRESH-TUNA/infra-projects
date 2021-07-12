resource "aws_launch_template" "appp" {
  image_id = "ami-00769a32524f14f01"

  instance_type = "t2.micro"

  name = "appp"

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

  user_data = base64encode(templatefile("${path.module}/user_data.sh.mock", 
  { 
    AWS_DEFAULT_REGION = var.aws_default_region
    ALLOCATION_ID = var.eip_allocation_id
    APP_ENVS_PATH = var.app_envs_path
    CLOUDFRONT_PRIVATE_KEY_ENV_PATH = var.app_cloudfront_private_key_env_path
  }))

  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.vpc_security_group_ids
  }

  iam_instance_profile {
    name = var.instance_profile_name
  }
}
