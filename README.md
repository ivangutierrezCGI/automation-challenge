# Automation Challenge

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {
  # Por defecto usará el socket de Docker en WSL: unix:///var/run/docker.sock
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
  name  = "nginx-automation"
  image = docker_image.nginx_automation.image_id
  restart = "unless-stopped"

  # Map ports: host -> container
  ports {
    internal = 80
    external = 80
  }

  # Más adelante añadiremos el puerto 443 para HTTPS.

  # Volume for static content (HTML)
  volumes {
    host_path      = "${path.module}/../html"
    container_path = "/usr/share/nginx/html"
  }
}






