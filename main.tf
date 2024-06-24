terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}



# resource "aws_instance" "web" {
#   ami                         = lookup(var.ami, var.aws_region)
#   instance_type               = "t3.micro"
#   user_data                   = <<-EOF
#       #!/bin/bash
#       echo "Hello World" > index.html
#       nohup busybox httpd -f -p ${var.portNumber} &
#       EOF
#   user_data_replace_on_change = true
#   security_groups             = [aws_security_group.instanceSecu.id]
#   subnet_id                   = "subnet-05794709f9a0ddd6c"
#   tags = {
#     Name = "HelloWorld"
#   }
# }
resource "aws_security_group" "instanceSecu" {
  name = "terraform-sg"
  vpc_id = "vpc-0e988c8c8520c81aa"
  ingress {
    from_port   = var.portNumber
    to_port     = var.portNumber
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

}

resource "aws_launch_template" "myLaunchConfig" {
image_id=lookup(var.ami,var.aws_region)
instance_type = "t2.micro"
# security_groupid = [aws_security_group.instanceSecu.id]
block_device_mappings{
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }
  }
user_data                = base64encode(
<<-EOF
      #!/bin/bash
      echo "Hello World" > index.html
      nohup busybox httpd -f -p ${var.portNumber} &
      EOF
      )
lifecycle {
  create_before_destroy = true
}
}


resource "aws_autoscaling_group" "myAutoScaleGrp" {
  #availability_zones=["us-east-1a","us-east-1b"]
  vpc_zone_identifier=["subnet-034c8b7cb1f1a6e70","subnet-0efdaee10254a1031"]
  launch_template {
    id      = aws_launch_template.myLaunchConfig.id
    version = "$Latest"
  }
  min_size = 2
  max_size = 3
  tag{
    key = "Name"
    value = "my-zaas-asg"
    propagate_at_launch = true
  }
  
}