variable "admin_user" {}   # Take Read and Store User Input

output "admin_user_is" {
    value = "${var.admin_user}"   # Referring to variable "admin_user"
}

output "Pass_is" {
    value = "${var.your_password}"  
}