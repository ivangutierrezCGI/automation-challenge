terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {
  # Usa el socket docker por defecto
}

# Build NGINX image from our Dockerfile
resource "docker_image" "nginx_automation" {
  name = "nginx-automation:latest"

  build {
    context    = "${path.module}/../nginx"
    dockerfile = "Dockerfile"
  }
}

# Run container
resource "docker_container" "nginx_automation" {
  name    = "nginx-automation"
  image   = docker_image.nginx_automation.image_id
  restart = "unless-stopped"

  # HTTP port
  ports {
    internal = 80
    external = 80
  }

  # HTTPS port
  ports {
    internal = 443
    external = 443
  }

  # Mount for static HTML
  mounts {
    target    = "/usr/share/nginx/html"
    source    = abspath("${path.module}/../html")
    type      = "bind"
    read_only = false
  }

  # Mount for TLS certificates
  mounts {
    target    = "/etc/nginx/certs"
    source    = abspath("${path.module}/../certs")
    type      = "bind"
    read_only = true
  }
}
