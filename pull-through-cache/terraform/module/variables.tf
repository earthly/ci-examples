variable "repository_to_mirror" {
  type        = string
  description = "The host of the repository to mirror"
}

variable "ssh_key" {
  type=object({
    public_key  = string
    fingerprint = string
  })
}

variable "htpasswd" {
  type        = string
  description = "The user/pass for the mirror"
}

variable "user_password" {
  type        = string
  description = "The password for the service user account"
}