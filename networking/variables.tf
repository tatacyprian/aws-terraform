#----------------------------networking/variables.tf--------------------------------------

variable "vpc_cidr" {
  description = "The CIDR block of the VPC."
  type        = string

}
variable "public__cidrs" {
  type=list(string)
}
variable "private_cidrs"{
  type=list(string)
}
variable "private_sn_count" {
  
}
variable "public_sn_count" {
  
}