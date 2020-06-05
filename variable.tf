variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}


variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "instance_tenancy" {
  default = "default"
}
variable "enable_dns_hostnames" {
  type = bool
  default = true
}
variable "enable_dns_support" {
  type = bool
  default = true
}
variable "enable_classiclink" {
  type = bool
  default = false
}

variable "tags" {
  type = string
  default = "vpc-custom-demo"
}
