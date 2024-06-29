variable "vpc_cidr" {
    type = string
  default = "172.23.0.0/16"
}
variable "private_sn_count" {
default = 3
}
variable "public_sn_count" {
  default = 3
}
