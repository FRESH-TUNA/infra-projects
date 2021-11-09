resource "aws_instance" "bastion" {
  ami           = "ami-0e4a9ad2eb120e054"
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.bastion.id
    device_index         = 0
  }

  key_name = aws_key_pair.knufesta2019.key_name
}

resource "aws_network_interface" "bastion" {
  subnet_id   = aws_subnet.public[0].id
  security_groups = [aws_security_group.bastion.id]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_security_group" "bastion" {
	name = "bastion"
	description = "sg"
	vpc_id = aws_vpc.knufesta2019.id

	tags = {
		Name = "kuberkuber-eks"
	}
}

resource "aws_security_group_rule" "bastion_inbound" {
  description              = "Allow worker nodes to communicate with the cluster API Server"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.bastion.id
  cidr_blocks              = ["0.0.0.0/0"]       
  type                     = "ingress"
}

resource "aws_security_group_rule" "bastion_outbound" {
  description              = "Allow worker nodes to communicate with the cluster API Server"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.bastion.id
  cidr_blocks              = ["0.0.0.0/0"]       
  type                     = "egress"
}
