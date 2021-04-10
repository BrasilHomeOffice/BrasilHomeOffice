# Variables
# variable "env_name" {
#   type = string
#   description = "Environment name (local, production, dev, staging, etc)"
# }
# variable "website_url" {
#   type = string
#   description = "The website url (http://local.brasilhomeoffice.com)"
# }
variable "network_name" {
  type = string
  description = "Docker network name"
}

# ---
# ENABLE & CONFIGURE DOCKER

# Require the docker provider
terraform {
  required_providers {
    # We recommend pinning to the specific version of the Docker Provider you're using
    # since new versions are released frequently
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.11.0"
    }
  }
}

# Enable docker provider
provider "docker" {
}

# Create docker network
resource "docker_network" "network" {
  name = var.network_name
}

# ---
# DOCKER IMAGES

# Traefik image
resource "docker_image" "traefik-image" {
  name = "traefik:2.4"
  keep_locally = true
  force_remove = true # Force remove to avoid bugs
}

## Traefik Whoami Image
##   A simple container which display some env variables
##   on a web server on port 80
#resource "docker_image" "traefik-whoami-image" {
#  name = "traefik/whoami:latest"
#  keep_locally = true
#  # Its just a simple little service, doesn't need force_remove = true
#}

# ---
# DOCKER CONTAINERS
#  Here you also configure hosts through Traefik
#  Traefik uses docker labels to automatically
#  proxy the requests to the right services

# Traefik
resource "docker_container" "traefik-container" {
  name = "traefik-container"
  image = docker_image.traefik-image.latest
  tty = true

  networks_advanced {
    name = docker_network.network.name
  }
  
  ports {
    internal = 80
    external = 80
  }

  ports {
    internal = 3306
    external = 3306
  }

  ports {
    internal = 443
    external = 443
  }

  # @INFRA_TODO
  #  When traefik is reachable through domain name
  #  remove this ports
  ports {
    internal = 8080
    external = 8080
  }

  # ---
  # @INFRA_TODO
  #  adjust this labels for traefik to work
  # 
  # ---
  # Traefik labels
  # labels {
  #   label = "traefik.enable"
  #   value = "true"
  # }
  # labels {
  #   label = "traefik.http.routers.traefik-dashboard.rule"
  #   value = "Host(`traefik-local.brasilhomeoffice.com`)"
  # }
  # labels {
  #   label = "traefik.http.routers.traefik-dashboard.entrypoints"
  #   value = "web"
  # }

  # Traefik config file
  volumes {
    host_path = abspath("../traefik/traefik-config.yml")
    container_path = "/etc/traefik/traefik.yml"
  }

  # Allow Traefik to read docker sock
  # required by Terraform's Docker provider
  volumes {
    host_path = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
    read_only = true
  }
}

## Traefik Whoami
#resource "docker_container" "traefik-whoami-container" {
#  name = "traefik-whoami-container"
#  image = docker_image.traefik-whoami-image.latest
#  tty = true
#
#  networks_advanced {
#    name = docker_network.network.name
#  }
#
#  # ---
#  # Traefik labels
#  labels {
#    label = "traefik.enable"
#    value = "true"
#  }
#  labels {
#    label = "traefik.http.routers.whoami.rule"
#    value = "Host(`ping.local.brasilhomeoffice.com`)"
#  }
#  labels {
#    label = "traefik.http.routers.whoami.entrypoints"
#    value = "web"
#  }
#}
