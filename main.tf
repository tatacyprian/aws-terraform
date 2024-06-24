terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
    }
  }
}



resource "aws_instance" "web" {
  ami           = lookup(var.ami,var.aws_region)
  instance_type = "t3.micro"
  security_groups = ["sg-072297680305f9e02"]
  subnet_id = "subnet-00d0c2249fa58f939"
  tags = {
    Name = "HelloWorld"
  }
}