#join Joins elements of a list into a single string with a specified separator.

output "user_names" {
  value = "Current User is ${join("----->", var.names)}"
}

# upper converts all cased letters in the given string to uppercase.
# title converts the first letter of each word in a string to uppercase.

output "upperTitle_names" {
  value = "upperTitle_names are ${upper(var.names[0])} and ${title(var.names[1])}"
}

# base64encode applies Base64 encoding to a string.

output "Name_encoded_base64" {
  value = "Name_encoded_base64 User is ${base64encode(var.names[0])}"
}