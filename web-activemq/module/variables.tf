variable "app_name" {}
variable "ami_id" {}
variable "instance_size" {}

variable "private_subnets" {}
variable "public_subnets" {}
variable "vpc_id" {}
variable "vpc_name" {}
variable "vpc_cidr" {}
variable "office_access_sg" {}

variable "tag_environment" {}
variable "tag_country" {}
variable "dns_domain_name" {}
variable "dns_public_zone_id" {}

variable "bastion-priv-ip" {}
variable "win-gateway-priv-ip" {}
variable "instance-priv-ips" {}
variable "no-of-instances" {}
