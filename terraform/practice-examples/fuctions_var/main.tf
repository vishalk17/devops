output "user_names" {
  value = "Current User is ${join("+++", var.names)}"
}