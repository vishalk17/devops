# map collection of key-value pairs.A collection of key-value pairs.

variable "price" {
    type = map
    default = {
        "Mobile" = "50k"
        "Laptop" = "85k"
    }
}

# lookup retrieves the value of a single element from a map, given its key. 
# If the given key does not exist, the given default value is returned instead.

output "Price_of_Laptop" {
    value = "Price of Laptop is ${lookup(var.price, "Laptop")}"
}