variable "aws_region" {
  description = "EU Frankfurt region"
  default     = "eu-central-1"
}

# specifying AZs 
variable "azs" {
  type = list
  default = ["eu-central-1a", "eu-central-1b"]
}

variable "public_subnets_cidr" {
  type = list
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
  type = list
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "ec2_user" {}
variable "private_key_public" {}
variable "private_key_private" {}
variable "public_key_public" {}
variable "public_key_private" {}
