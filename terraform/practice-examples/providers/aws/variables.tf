variable "auth" {
  type = map(any)
}

variable "ami" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "region" {
  type = string
}

variable "ports_list" {
  type = list(number)
}