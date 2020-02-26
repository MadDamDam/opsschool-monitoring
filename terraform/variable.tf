variable "aws_access_key" {
}

variable "aws_secret_key" {
}

variable "aws_region" {
  default = "us-east-1"
}

variable "default_keypair_name" {
  description = "Name of the KeyPair used for all nodes"
}

variable "monitor_instance_type" {
  default = "t2.micro"
}

variable "monitor_servers" {
  default = "1"
}

variable "owner" {
  default = "Monitoring"
}

variable "vpc_id" {
  description = "ID of vpc to create instances in in the format vpc-xxxxxxxx"
}

