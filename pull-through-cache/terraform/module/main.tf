
data "template_file" "cloud-init" {
  template = file("${path.module}/cloud-init.yaml")
  vars = {
    init_ssh_public_key       = var.ssh_key.public_key
    init_htpasswd             = var.htpasswd
    init_repository_to_mirror = var.repository_to_mirror
    init_user_password        = var.user_password
  }
}

resource "digitalocean_droplet" "docker_cache" {
  image      = "ubuntu-20-04-x64"
  name       = "docker-cache-${var.repository_to_mirror}"
  region     = "sfo3"
  size       = "s-1vcpu-1gb"
  monitoring = true
  ssh_keys   = [var.ssh_key.fingerprint]
  user_data  = data.template_file.cloud-init.rendered
}

resource "digitalocean_firewall" "docker_cache" {
  name = "${var.repository_to_mirror}-firewall"

  droplet_ids = [digitalocean_droplet.docker_cache.id]

  # If you want SSH access do a manual tweak to the firewall
  # Allow only from your IP

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}