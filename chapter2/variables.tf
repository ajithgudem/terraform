variable "server_http_port" {
    description   = "The port the server will use for HTTP requests"
    type          = number
    default     = 8080
}


variable "elb_http_port" {
    description   = "The port the elb will use for HTTP requests"
    type          = number
    default     = 80
}