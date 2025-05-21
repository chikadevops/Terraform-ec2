variable "public_key" {
  description = "The public SSH key"
  type        = string
}

variable "ami_value" {
  description = "The AMI ID to be used for the instance."
  type        = string
}

variable "instance_type" {
  description = "The type of instance to be created."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "The security group IDs to associate with the instance."
  type        = list(string)
}

variable "region" {
  description = "The AWS region to deploy the resources in."
  type        = string
}
