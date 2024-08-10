module "instance" {
  source             = "./instance-module"

# overriding variables values
# module var names from variable_md.tf = new_overiding_variables.tf (will refer prod.tfvars for values)
  instance_key_md = aws_key_pair.instance_key.key_name
  instance_name_md = var.instance_name
  instance_type_md = var.instance_type
}

output "public_ip" {
  value = module.instance.instance_public_ip
}