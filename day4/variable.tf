
variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "my default region"
}


variable "vm_name" {
  type    = string
  default = "my_linux"

}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "this cidr block is for the vpc"
}

variable "subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "this cidr block is for the subnet"
}



locals {
  getdate = formatdate("YYYYMMDDhhmmss", timestamp())
}

