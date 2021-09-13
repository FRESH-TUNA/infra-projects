resource "aws_instance" "nat" {
  instance_type = "t2.micro"

  launch_template {
    id = var.nat_launch_template_id
    version = "$Latest"
  } 
  subnet_id = var.nat_subnet_id

  associate_public_ip_address = true
# option
#   network_interface {
#     network_interface_id = aws_network_interface.foo.id
#     device_index         = 0
#   }

# burstable instance settings
#   credit_specification {
#     cpu_credits = "unlimited"
#   }

  vpc_security_group_ids = var.nat_sg_ids
}
