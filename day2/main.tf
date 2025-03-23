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

resource "aws_s3_bucket" "remote_state" {

  bucket = "my-terraform-state-bucket-${local.getdate}"
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket                  = aws_s3_bucket.remote_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.remote_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encrytion" {
  bucket = aws_s3_bucket.remote_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}


resource "aws_dynamodb_table" "remote_state_lock" {
  name         = "terraform-state-lock-${local.getdate}"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_instance" "my_linux_vm" {
  ami             = "ami-08b5b3a93ed654d19"
  subnet_id       = aws_subnet.my_subnet.id
  security_groups = [aws_security_group.my_sg.id]
  tags = {
    Name = var.vm_name
  }
  instance_type = "t3.small"
}

resource "aws_security_group" "my_sg" {
  description = "allow the port 22 access from anywhere"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name = "my_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "inbound_ssh" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  tags = {
    Name = "allow_inbound_ssh"
  }

}

resource "aws_vpc_security_group_egress_rule" "outbound_all" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
  tags = {
    Name = "allow_outbound_all"
  }
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


