terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "my_linux_vm" {
  ami       = "ami-08b5b3a93ed654d19"
  subnet_id = aws_subnet.my_subnet.id
  tags = {
    Name = var.vm_name
  }
  instance_type = "t3.small"
}

resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my_first_vpc"
  }
}


resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.5.0/24"

  tags = {
    Name = "my_private_subnet"
  }
}


