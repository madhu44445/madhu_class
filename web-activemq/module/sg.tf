resource "aws_security_group" "sg" {
  name = "${var.app_name}.${var.tag_environment}"
  description = "Allows access to ${var.app_name}"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.app_name}.${var.tag_environment}"
    Project = "${var.vpc_name}"
  }

  # allow SSH access to the server.
  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["${var.bastion-priv-ip}/32"]
  }

# MQ access
  ingress {
    from_port = "8161"
    to_port = "8161"
    protocol = "tcp"
    cidr_blocks = ["${var.bastion-priv-ip}/32","${var.win-gateway-priv-ip}/32","${var.vpc_cidr}"]
  }

# MQ access
  ingress {
    from_port = "61616"
    to_port = "61616"
    protocol = "tcp"
    cidr_blocks = ["${var.bastion-priv-ip}/32","${var.win-gateway-priv-ip}/32","${var.vpc_cidr}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = "true"
  }
}

output "sg_instance" {
  value = "${aws_security_group.sg.id}"
}
