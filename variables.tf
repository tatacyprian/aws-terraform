variable "ami" {
  type = map(string)
  default = {
    "us-east-1" = "ami-0a640b520696dc6a8"
  }
}
variable "aws_region" {
  type = string
  default = "us-east-1"
}