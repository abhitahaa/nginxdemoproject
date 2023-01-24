provider "aws" {
  region = "us-east-1"
}


/* resource "aws_instance" "ec2_example" {

  ami                    = "ami-06878d265978313ca"
  instance_type          = "t2.micro"
  key_name               = "aws_key"
  vpc_security_group_ids = [aws_security_group.example.id]
  subnet_id              = aws_subnet.public.id

  provisioner "local-exec" {
    command = "aws ec2 describe-instances --instance-ids $(aws_instance.ec2_example.id) --query 'Reservations[*].Instances[*].PublicIpAddress' --output text >> /etc/ansible/hosts"
  }
}
 */

# resource "aws_security_group" "main" {
#   vpc_id = aws_vpc.example.id
#   egress = [
#     {
#       cidr_blocks      = ["0.0.0.0/0", ]
#       description      = ""
#       from_port        = 0
#       ipv6_cidr_blocks = []
#       prefix_list_ids  = []
#       protocol         = "-1"
#       security_groups  = []
#       self             = false
#       to_port          = 0
#     }
#   ]
#   ingress = [
#     {
#       cidr_blocks      = ["0.0.0.0/0", ]
#       description      = ""
#       from_port        = 22
#       ipv6_cidr_blocks = []
#       prefix_list_ids  = []
#       protocol         = "tcp"
#       security_groups  = []
#       self             = false
#       to_port          = 22
#     }
#   ]
# }

/* 
resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = file("/Users/abhishekbhandari/Documents/keys/aws/aws_key.pub")
}

 */