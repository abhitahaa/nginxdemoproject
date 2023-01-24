
/*
# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

data "local_file" "install_dependencies" {
  filename = "install.sh"
}

# # Create a new EC2 instance
# resource "aws_instance" "my_instance" {
#   # Other configuration options...

#   # Use the contents of the shell script as an inline provisioner
#   provisioner "remote-exec" {
#     inline = [data.local_file.install_dependencies.content]
#   }
# }



# Create a new EC2 instance
# resource "aws_instance" "my_instance" {
#   ami                    = "ami-06878d265978313ca"
#   instance_type          = "t2.medium"
#   key_name               = aws_key_pair.key121.key_name
#   subnet_id              = aws_subnet.public.id
#   vpc_security_group_ids = [aws_security_group.example.id]
#   #user_data       = templatefile("install.sh", {})
#   provisioner "file" {
#     source      = "install.sh"
#     destination = "/tmp/install.sh"
#   }
#   provisioner "remote-exec" {
#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       host        = aws_instance.my_instance.public_ip
#       private_key = tls_private_key.oskey.private_key_pem
#     }
#     inline = [
#       "chmod +x /tmp/install.sh",
#       "sudo /tmp/install.sh"
#     ]
#   }
# }

# resource "aws_key_pair" "key121" {
#   key_name   = "myterrakey"
#   public_key = tls_private_key.oskey.public_key_openssh
# }

# resource "tls_private_key" "oskey" {
#   algorithm = "RSA"
# }

# resource "local_file" "myterrakey" {
#   content  = tls_private_key.oskey.private_key_pem
#   filename = "myterrakey.pem"
# }

# this works #
resource "aws_instance" "my_instance" {
  ami                    = "ami-06878d265978313ca"
  instance_type          = "t2.medium"
  key_name               = "jenkins"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.example.id]
  user_data              = <<EOF

#!/bin/bash

sudo apt update -y
sudo apt install nginx -y
sudo apt install software-properties-common -y
sudo apt update -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt install php8.1-fpm php8.1-mysql php8.1-gd php8.1-cli php8.1-curl php8.1-mbstring php8.1-zip php8.1-opcache -y
sudo systemctl start nginx
sudo systemctl start php8.1-fpm

EOF
}


# resource "aws_instance" "my_instance" {
#   ami                    = "ami-0b93ce03dcbcb10f6"
#   instance_type          = "t2.medium"
#   key_name               = "jenkins"
#   subnet_id              = aws_subnet.public.id
#   vpc_security_group_ids = [aws_security_group.example.id]
#   user_data              = <<EOF

# user_data = <<EOF
                    # #!/bin/bash

                    # # Update package list and upgrade installed packages
                    # sudo apt-get update
                    # sudo apt-get upgrade -y

                    # # Install Nginx
                    # sudo apt-get install nginx -y

                    # # Install PHP and required modules
                    # sudo apt-get install php8.1-fpm php8.1-cli php8.1-common php8.1-mbstring php8.1-gd php8.1-intl php8.1-xml php8.1-mysql php8.1-zip -y

                    # # Start Nginx and PHP-FPM services
                    # sudo systemctl start nginx
                    # sudo systemctl start php8.1-fpm
            # EOF
# }


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu.id
}

*/

resource "tls_private_key" "nginxkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "nginxkp" {
  key_name   = "myKey"       # Create a "myKey" to AWS!!
  public_key = tls_private_key.nginxkey.public_key_openssh

  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.nginxkey.private_key_pem}' > ./myKey.pem"
  }
}

# Create a new EC2 instance
resource "aws_instance" "nginx" {
  ami                    = "ami-06878d265978313ca"
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.example.id]
#    provisioner "remote-exec" {
#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       host        = aws_instance.my_instance.public_ip
#       private_key = tls_private_key.oskey.private_key_pem
#     }
#     inline = [
#       "chmod +x /tmp/install.sh",
#       "sudo /tmp/install.sh"
#     ]
#   }
}


resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tpl",
    {
      nginx-hosts = aws_instance.nginx[*].public_ip
      keyfile = file("${path.module}/myKey.pem")
    }
  )
  filename = "./ansible/inventory/hosts.cfg"
  depends_on = [ aws_instance.nginx ]
}

