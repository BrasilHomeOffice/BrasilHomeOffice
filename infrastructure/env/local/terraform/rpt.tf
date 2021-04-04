# React Para Trabalho

# Image
resource "docker_image" "rpt-image" {
  name = "rpt"
  keep_locally = true
  force_remove = false

  build {
    path = "../../../../"
    dockerfile = "./infrastructure/env/local/rpt/Dockerfile"
  }
}

# Container
resource "docker_container" "rpt-container" {
  name    = "rpt"
  image   = docker_image.rpt-image.latest
  tty = true

  networks_advanced {
    name = docker_network.network.name
  }

  # ---
  # Enable hot reload
  #  I'm putting all files that are in repos/rpt root folder
  # @TODO
  #  put all the source code inside src folder
  # @QUESTION
  #  is it possible to compress this lot of lines?
  volumes {
    container_path = "/app/components"
    host_path = abspath("../../../../repos/rpt/components")
  }
  volumes {
    container_path = "/app/data"
    host_path = abspath("../../../../repos/rpt/data")
  }
  volumes {
    container_path = "/app/falcor"
    host_path = abspath("../../../../repos/rpt/falcor")
  }
  volumes {
    container_path = "/app/pages"
    host_path = abspath("../../../../repos/rpt/pages")
  }
  volumes {
    container_path = "/app/public"
    host_path = abspath("../../../../repos/rpt/public")
  }
  volumes {
    container_path = "/app/styles"
    host_path = abspath("../../../../repos/rpt/styles")
  }
  volumes {
    container_path = "/app/utils"
    host_path = abspath("../../../../repos/rpt/utils")
  }
  volumes {
    container_path = "/app/.babelrc"
    host_path = abspath("../../../../repos/rpt/.babelrc")
  }
  volumes {
    container_path = "/app/.gitignore"
    host_path = abspath("../../../../repos/rpt/.gitignore")
  }
  volumes {
    container_path = "/app/.upignore"
    host_path = abspath("../../../../repos/rpt/.upignore")
  }
  volumes {
    container_path = "/app/next.config.js"
    host_path = abspath("../../../../repos/rpt/next.config.js")
  }
  volumes {
    container_path = "/app/package.json"
    host_path = abspath("../../../../repos/rpt/package.json")
  }
  volumes {
    container_path = "/app/README.md"
    host_path = abspath("../../../../repos/rpt/README.md")
  }
  volumes {
    container_path = "/app/server.js"
    host_path = abspath("../../../../repos/rpt/server.js")
  }
  volumes {
    container_path = "/app/up.json"
    host_path = abspath("../../../../repos/rpt/up.json")
  }

  # ---
  # Traefik labels
  labels {
    label = "traefik.enable"
    value = "true"
  }
  labels {
    label = "traefik.http.routers.rpt.rule"
    value = "Host(`rpt.local.brasilhomeoffice.com`)"
  }
  labels {
    label = "traefik.http.routers.rpt.entrypoints"
    value = "web"
  }
  # Redirect to port 3000 inside the container
  # because `yarn dev` uses this port
  labels {
    label = "traefik.http.services.rpt.loadbalancer.server.port"
    value = "3000"
  }
}
