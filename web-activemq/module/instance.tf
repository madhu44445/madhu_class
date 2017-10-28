# EC2 Instance
data "template_file" "instance_userdata" {
  template = "${file("${path.module}/instance-userdata.tpl")}"
}
# Instance iteration based on "no-of-instances" variable
resource "aws_instance" "instance_1" {
  count = "${var.no-of-instances}"
  instance_type           = "${var.instance_size}"
  ami                     = "${var.ami_id}"
  key_name                = "${var.tag_environment}"
  disable_api_termination = "false"
  vpc_security_group_ids  = ["${aws_security_group.sg.id}"]
  subnet_id               = "${element(split(",", var.private_subnets), 0)}"
  iam_instance_profile    = "${aws_iam_instance_profile.profile_1.id}"
  monitoring              = "true"
  private_ip              = "${element(split(",", var.instance-priv-ips), 0)}"
  user_data               = "${data.template_file.instance_userdata.rendered}"


  tags {
    Name = "${var.app_name}.${var.tag_environment}"
    environment = "${var.tag_environment}"
    INSTANCE_SCOPE = "${var.app_name}"
    datadog = "monitored"
    Project = "AMP"
    Country = "${var.tag_country}"
  }
}
