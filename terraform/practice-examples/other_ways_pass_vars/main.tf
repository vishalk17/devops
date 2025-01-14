# map collection of key-value pairs.A collection of key-value pairs.

variable "price" {
    type = map
}

variable "item" {
    type = string
}

variable "my_key" {
    type = string
}

# lookup retrieves the value of a single element from a map, given its key. 
# If the given key does not exist, the given default value is returned instead.

output "Prices" {
    value = "Price of ${var.item} is ${lookup(var.price, "${var.item}")}"
}

output "key" {
    value = "Key is ${var.my_key}"
  
}