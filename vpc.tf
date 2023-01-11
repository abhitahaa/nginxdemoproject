
# # Create VPC
# resource "aws_vpc" "example" {
#   cidr_block = "10.0.0.0/16"
# }

# # Create Internet Gateway
# resource "aws_internet_gateway" "example" {
#   vpc_id = aws_vpc.example.id
# }

# # Create Public Subnet
# resource "aws_subnet" "public" {
#   vpc_id                  = aws_vpc.example.id
#   cidr_block              = "10.0.1.0/24"
#   map_public_ip_on_launch = true
#   availability_zone       = "us-east-1a"
# }

# # #Create Private Subnet
# # resource "aws_subnet" "public2" {
# #   vpc_id                  = aws_vpc.example.id
# #   cidr_block              = "10.0.2.0/24"
# #   map_public_ip_on_launch = false
# #   availability_zone       = "us-east-1b"
# # }

# # Create Public Route Table
# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.example.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.example.id
#   }
# }

# # Create Private Route Table
# # resource "aws_route_table" "private" {
# #   vpc_id = aws_vpc.example.id
# # }

# # Associate Public Route Table with Public Subnet
# resource "aws_route_table_association" "public" {
#   subnet_id      = aws_subnet.public.id
#   route_table_id = aws_route_table.public.id
# }

# # Associate Private Route Table with Private Subnet
# # resource "aws_route_table_association" "private" {
# #   subnet_id      = aws_subnet.private.id
# #   route_table_id = aws_route_table.private.id
# # }


# #Create Security Group
# resource "aws_security_group" "example" {
#   name        = "example"
#   description = "Security group for example"
#   vpc_id      = aws_vpc.example.id

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     cidr_blocks     = ["0.0.0.0/0"]
#     prefix_list_ids = []
#   }
# }

