# Get Ubuntu AMI information 
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

# Get Subnet Id for the VPC
data "aws_subnet_ids" "subnets" {
  vpc_id = var.vpc_id
}

#Monitoring Security Group
resource "aws_security_group" "monitor_sg" {
  name        = "monitor_sg_1"
  description = "Security group for monitoring server"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow ICMP from control host IP
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all SSH External
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all traffic to HTTP port 3000
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all traffic to HTTP port 9090
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Allocate the EC2 monitoring instance
resource "aws_instance" "monitor" {
  count         = var.monitor_servers
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.monitor_instance_type

  subnet_id              = element(tolist(data.aws_subnet_ids.subnets.ids), count.index)
  vpc_security_group_ids = [aws_security_group.monitor_sg.id]
  key_name               = var.default_keypair_name

  associate_public_ip_address = true

  tags = {
    Owner = var.owner
    Name  = "Monitor-${count.index}"
  }
}

output "monitor_server_public_ip" {
  value = join(",", aws_instance.monitor.*.public_ip)
}

