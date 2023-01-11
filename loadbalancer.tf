# # Create Application Load Balancer
# resource "aws_lb" "example" {
#   name               = "example-lb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.example.id]
#   subnets            = [aws_subnet.public.id, aws_subnet.public2.id]

#   idle_timeout               = 60
#   enable_deletion_protection = false

#   #   health_check {
#   #     ping_path           = "/health"
#   #     interval            = 30
#   #     timeout             = 5
#   #     healthy_threshold   = 2
#   #     unhealthy_threshold = 2
#   #     healthy_http_codes  = "200,301,302"
#   #   }

#   #   listener {
#   #     port     = "80"
#   #     protocol = "HTTP"

#   #     default_action {
#   #       target_group_arn = aws_lb_target_group.example.arn
#   #       type             = "forward"
#   #     }
#   #   }
#   # 
# }

# # Create Target Group
# resource "aws_lb_target_group" "example" {
#   name     = "example-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.example.id

#   health_check {
#     path                = "/health"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     matcher             = "200-299"
#   }
# }

# # Create Launch Configuration
# resource "aws_launch_configuration" "example" {
#   name_prefix                 = "example-lc-"
#   image_id                    = "ami-06878d265978313ca"
#   instance_type               = "t2.micro"
#   key_name                    = "jenkins"
#   security_groups             = [aws_security_group.example.id]
#   user_data                   = base64encode(data.local_file.install_dependencies.content)
#   associate_public_ip_address = true

#   root_block_device {
#     volume_size = "20"
#     volume_type = "gp2"
#   }
# }

# # Create Auto Scaling Group
# resource "aws_autoscaling_group" "example" {
#   name                 = "example-asg"
#   min_size             = 1
#   max_size             = 5
#   desired_capacity     = 1
#   vpc_zone_identifier  = [aws_subnet.public.id, aws_subnet.public2.id]
#   launch_configuration = aws_launch_configuration.example.name
#   #user_data                 = base64encode(data.local_file.install_dependencies.content)
#   target_group_arns         = ["${aws_lb_target_group.example.arn}"]
#   health_check_grace_period = 300
#   wait_for_capacity_timeout = "10m"

#   tag {
#     key                 = "Name"
#     value               = "example"
#     propagate_at_launch = true
#   }
# }

# Create Data Template for User Data
# data "template_file" "example" {
#   template = "${file("install.sh")}"

# }