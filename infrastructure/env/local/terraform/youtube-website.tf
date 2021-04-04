# Youtube Website

# Image
resource "docker_image" "youtube-website-image" {
  name = "youtube-website"
  keep_locally = true
  force_remove = false

  build {
    path = "../../../../"
    dockerfile = "./infrastructure/env/local/youtube-website/Dockerfile"
  }
}

# Container
resource "docker_container" "youtube-website-container" {
  name    = "youtube-website"
  image   = docker_image.youtube-website-image.latest
  tty = true

  networks_advanced {
    name = docker_network.network.name
  }

  # ---
  # Enable hot reload
  volumes {
    container_path = "/app/src"
    host_path = abspath("../../../../repos/youtube-website/src")
  }
  volumes {
    container_path = "/app/public"
    host_path = abspath("../../../../repos/youtube-website/public")
  }
  # volumes {
  #   container_path = "/app/.babelrc"
  #   host_path = abspath("../../../../repos/youtube-website/.babelrc")
  # }
  # volumes {
  #   container_path = "/app/.gitignore"
  #   host_path = abspath("../../../../repos/youtube-website/.gitignore")
  # }
  # volumes {
  #   container_path = "/app/.upignore"
  #   host_path = abspath("../../../../repos/youtube-website/.upignore")
  # }
  # volumes {
  #   container_path = "/app/next.config.js"
  #   host_path = abspath("../../../../repos/youtube-website/next.config.js")
  # }
  volumes {
    container_path = "/app/package.json"
    host_path = abspath("../../../../repos/youtube-website/package.json")
  }
  # volumes {
  #   container_path = "/app/README.md"
  #   host_path = abspath("../../../../repos/youtube-website/README.md")
  # }
  # volumes {
  #   container_path = "/app/server.js"
  #   host_path = abspath("../../../../repos/youtube-website/server.js")
  # }
  # volumes {
  #   container_path = "/app/up.json"
  #   host_path = abspath("../../../../repos/youtube-website/up.json")
  # }

  # ---
  # Traefik labels
  labels {
    label = "traefik.enable"
    value = "true"
  }
  labels {
    label = "traefik.http.routers.youtube-website.rule"
    value = "Host(`vlog.local.brasilhomeoffice.com`)"
  }
  labels {
    label = "traefik.http.routers.youtube-website.entrypoints"
    value = "web"
  }
  # Redirect to port 3000 inside the container
  # because `yarn dev` uses this port
  labels {
    label = "traefik.http.services.rpt.loadbalancer.server.port"
    value = "3000"
  }
}
