terraform {
  required_version = ">= 0.13"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# PK is in 1Password.
resource "digitalocean_ssh_key" "default" {
  name       = "Docker Cache Key"
  public_key = file("./cache-key.pub")
}

module "staging_docker_io_cache" {
  source = "../module"

  repository_to_mirror = "registry-1.docker.io"
  ssh_key              = digitalocean_ssh_key.default
  htpasswd             = var.docker_htpasswd
  user_password        = var.user_password
}