#------------------------------------networking/main.tf-------------------------------------------------------
resource "random_integer" "random" {
  min=1
  max = 10
}

resource "aws_vpc" "ambatech" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
  tags = {
    Name = "ambatech-vpc-${random_integer.random.id}"
  }
}
resource "aws_subnet" "ambatech-subnetpub" {
  count=var.public_sn_count
  vpc_id =aws_vpc.ambatech.id
  cidr_block = var.public__cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = ["us-east-1a","us-east-1b","us-east-1c"][count.index]
tags = {
  Name="ambatech-subnet-${count.index +1}"
}
}
resource "aws_subnet" "privatesub" {
  cidr_block = var.private_cidrs[count.index]
   availability_zone = ["us-east-1a","us-east-1b","us-east-1c"][count.index]
  vpc_id = aws_vpc.ambatech.id
  count=var.private_sn_count
  tags={
    Name="ambatech-subnetprivate-${count.index+ 1}"
  }
}