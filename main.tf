#------------------------------------root/main.tf---------------------------
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

module "networking" {
  source = "./networking"
  vpc_cidr =var.vpc_cidr
  private_sn_count=var.private_sn_count
  public_sn_count=var.public_sn_count
  public__cidrs=[for i in range(1,6,2): cidrsubnet("172.23.0.0/16",4,i)]
  private_cidrs = [for i in range(6,11,2): cidrsubnet("172.23.0.0/16",4,i)]
}


# resource "aws_vpc" "amba-vpc" {
#    cidr_block = "10.0.0.0/16"
# }
# resource "aws_security_group" "instanceSecu" {
#   name   = "terraform-sg"
#   vpc_id = var.vpc_id
#   ingress {
#     from_port   = var.portNumber
#     to_port     = var.portNumber
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]

#   }


# }
# # resource "aws_subnets" "subnets" {
# #   cidr_block=var.cidr_block
# #   enable_dns_hostnames=true
# #   enable_dns_support=true
# #   tag{
# #     Name=private-sub-len(var.availability_zone).index
# #   }
# #   }

# # resource "aws_alb" "zaasAlb" {
# #   name               = "zaas-alb"
# #   subnets            = [data.aws_subnets.subnets.id]
# #   load_balancer_type = "application"
# #   security_groups    = [aws_security_group.alb.id]
# # }
# # resource "aws_lb_listener" "http_listener" {
# #   load_balancer_arn = aws_alb.zaasAlb.arn
# #   port              = 80
# #   protocol          = "HTTP"
# #   default_action {
# #     type = "fixed-response"
# #     fixed_response {
# #       content_type = "text/plain"
# #       message_body = "404: page not found dude"
# #       status_code  = 404
# #     }
# #   }
# # }
# # resource "aws_lb_listener_rule" "alb-listener" {
# #   listener_arn = aws_lb_listener.http_listener.arn
# #   priority     = 100
# #   condition {
# #     path_pattern {
# #       values = ["*"]
# #     }
# #   }
# #   action {
# #     type             = "forward"
# #     target_group_arn = aws_alb_target_group.asg.arn
# #   }

# # }

# # resource "aws_alb_target_group" "asg" {
# #   name     = "alb-target-group"
# #   port     = var.portNumber
# #   protocol = "HTTP"
# #   vpc_id   = aws_vpc.amba-vpc.id
# #   health_check {
# #     path                = "/"
# #     protocol            = "HTTP"
# #     matcher             = "200"
# #     interval            = 15
# #     timeout             = 3
# #     healthy_threshold   = 2
# #     unhealthy_threshold = 2
# #   }
# # }
# resource "aws_security_group" "alb" {
#   name = "alb-sg"
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
# resource "aws_launch_template" "myLaunchConfig" {
#   name_prefix            = "zaas-launchTemplate"
#   image_id               = lookup(var.ami, var.aws_region)
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [aws_security_group.instanceSecu.id]
#   block_device_mappings {
#     device_name = "/dev/sdf"

#     ebs {
#       volume_size = 20
#     }
#   }
#   user_data = base64encode(templatefile("user-data.sh", {
#   portNumber = var.portNumber }))

#   lifecycle {
#     create_before_destroy = true
#   }
# }


# resource "aws_autoscaling_group" "myAutoScaleGrp" {
#   # name_prefix = "zaas-asg"
#   #availability_zones=["us-east-1a","us-east-1b"]
#   # security_group_names = [aws_security_group.instanceSecu.id]
  # target_group_arns   = [aws_alb_target_group.asg.arn]
#   health_check_type   = "ELB"
#   vpc_zone_identifier = ["subnet-034c8b7cb1f1a6e70"]
#   launch_template {
#     id      = aws_launch_template.myLaunchConfig.id
#     version = "$Latest"
#   }
#   min_size = 2
#   max_size = 3
#   tag {
#     key                 = "Name"
#     value               = "my-zas-asg"
#     propagate_at_launch = true
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
#   instance_refresh {
#     strategy = "Rolling"
#     preferences {
#       min_healthy_percentage = 50
#     }
#     triggers = ["tag"]
#   }
# }
