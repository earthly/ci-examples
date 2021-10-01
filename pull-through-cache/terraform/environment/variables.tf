variable "do_token" {
  type        = string
  description = "The DigitalOcean API key you generated"
}

variable "docker_htpasswd" {
  type        = string
  description = "The htpasswd to use when configuring a pull-through cache"
}

variable "user_password" {
  type        = string
  description = "The password for the service user account"
}