# Configure the AWS Provider
provider "aws" {
  region = "${var.aws_region}"
  profile = "internal"
}

# Store terraform state to S3
terraform {
  required_version = "0.9.11"
  backend "s3" {
    bucket = "amp-state"
    key    = "apps/qa/web-activemq.tfstate"
    region = "eu-west-1"
  }
}
# Import VPC state
data "terraform_remote_state" "network" {
  backend = "s3"
  config {
    bucket = "amp-state"
    key    = "network/network.qa.tfstate"
    region = "eu-west-1"
  }
}

# Import Route53 state
data "terraform_remote_state" "route53" {
  backend = "s3"
  config {
    bucket = "amp-state"
    key    = "route53/dev-qa/route53.bigcontent-cloud.tfstate"
    region = "eu-west-1"
  }
}

module "activemq" {
  source = "../module"

  # network settings
  vpc_name = "${var.vpc_name}"
  vpc_id = "${data.terraform_remote_state.network.vpc-id}"
  vpc_cidr = "${data.terraform_remote_state.network.vpc-cidr}"
  private_subnets = "${data.terraform_remote_state.network.private-subnets}"
  public_subnets = "${data.terraform_remote_state.network.public-subnets}"
  office_access_sg = "${data.terraform_remote_state.network.office_access_sg}"

  # intance size
  instance_size = "t2.micro"

  # app specific settings
  app_name = "web-activemq"
  ami_id = "${var.ami_id}"
  no-of-instances = "1"
  instance-priv-ips = "${var.activemq-priv-ips}"
  bastion-priv-ip = "${var.bastion-priv-ip}"
  win-gateway-priv-ip = "${var.win-gateway-priv-ip}"

  # tag settings
  tag_environment = "${var.tag_environment}"
  tag_country = "${var.tag_country}"

  # DNS configuration
  dns_public_zone_id = "${data.terraform_remote_state.route53.route53-qa-bigcontent-cloud}"
  dns_domain_name = "${var.dns_domain_name}"
}

output "activemq-priv-ips" {
  value = "${var.activemq-priv-ips}"
}

#output "endpoint-1" {
#  value = "${module.activemq.endpoint-1}"
#}

