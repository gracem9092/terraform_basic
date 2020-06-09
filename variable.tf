variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}

# VPC
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

# EC2
variable "ami_id" {
  default = "ami-09d95fab7fff3776c"
}
variable "instance_type" {
  default = "t3.micro"
}
variable "key_name" {
  default = "ec2-demo"
}
