variable "instance_name_md" {
  description = "This field is for Instance Name"
  type = string
}

variable "instance_type_md" {
  description = "This field is for Instance Type"
  type = string
  default = "t2.small"
}

variable "instance_key_md" {
  type = string
}