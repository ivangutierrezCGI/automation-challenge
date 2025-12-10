terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {
  # Usará el socket por defecto: unix:///var/run/docker.sock en WSL
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

  # Map ports: host -> container
  ports {
    internal = 80
    external = 80
  }

  # Bind mount: host html folder -> container html folder
  mounts {
    target = "/usr/share/nginx/html"                 # dentro del contenedor
    source = abspath("${path.module}/../html")       # carpeta html del proyecto en tu host
    type   = "bind"
    read_only = false
  }
}
