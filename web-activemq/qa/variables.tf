# aws region
variable "aws_region" {
  default = "eu-west-1"
}

# account id AMP-Internal
variable "aws_account_id" {
  default = "173365125512"
}

# vpc_name
variable "vpc_name" {
  default = "amp"
}

# vpc id to build CIDR (see README)
variable "vpc_cidr" {
  default = "130"
}

variable "ami_id" {
  default = "ami-3838d741"  # ami-3838d741
}

# tags
variable "tag_environment" {
  default = "qa"
}

variable "tag_country" {
  default = "GB"
}

variable "dns_domain_name" {
  default = "qa.bigcontent.cloud"
}

variable "bastion-priv-ip" {
  default = "10.25.25.25"
}

variable "win-gateway-priv-ip" {
  default = "10.25.112.25"
}

variable "activemq-priv-ips" {
  default = "10.130.23.185"
}
