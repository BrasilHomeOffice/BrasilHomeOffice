# Youtube Website

#####################################################################
# Nextjs Website

# Image
resource "docker_image" "youtube-website-image" {
  name = "youtube-website"
  keep_locally = true
  force_remove = true

  build {
    path = "../../../../"
    dockerfile = "./infrastructure/env/local/youtube-website/Dockerfile-website"
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
  volumes {
    container_path = "/app/.babelrc"
    host_path = abspath("../../../../repos/youtube-website/.babelrc")
  }
  volumes {
    container_path = "/app/.gitignore"
    host_path = abspath("../../../../repos/youtube-website/.gitignore")
  }
  volumes {
    container_path = "/app/.upignore"
    host_path = abspath("../../../../repos/youtube-website/.upignore")
  }
  volumes {
    container_path = "/app/next.config.js"
    host_path = abspath("../../../../repos/youtube-website/next.config.js")
  }
  volumes {
    container_path = "/app/package.json"
    host_path = abspath("../../../../repos/youtube-website/package.json")
  }
  volumes {
    container_path = "/app/README.md"
    host_path = abspath("../../../../repos/youtube-website/README.md")
  }
  volumes {
    container_path = "/app/server.js"
    host_path = abspath("../../../../repos/youtube-website/server.js")
  }
  volumes {
    container_path = "/app/up.json"
    host_path = abspath("../../../../repos/youtube-website/up.json")
  }

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
    value = "websecure"
  }
  labels {
    label = "traefik.http.routers.youtube-website.tls"
    value = "true"
  }
  labels {
    label = "traefik.http.services.youtube-website.loadbalancer.server.port"
    value = "80"
  }
}


#####################################################################
# API

# Image
resource "docker_image" "youtube-api-image" {
 name = "youtube-api"
 keep_locally = true
 force_remove = true

 build {
   path = "../../../../"
   dockerfile = "./infrastructure/env/local/youtube-website/Dockerfile-api"
 }
}

# Container
resource "docker_container" "youtube-api-container" {
 name    = "youtube-api"
 image   = docker_image.youtube-api-image.latest
 tty = true

 networks_advanced {
   name = docker_network.network.name
 }

 env = [
   # "DATABASE_URL=mysql://root:root@db-vlog.local.brasilhomeoffice.com:3306/youtube-db"
   "DATABASE_URL=mysql://root:root@youtube-db:3306/youtube-db"
 ]

  # ---
  # Enable hot reload
  volumes {
    container_path = "/app/src"
    host_path = abspath("../../../../repos/youtube-api/src")
  }

 # ---
 # Traefik labels
 labels {
   label = "traefik.enable"
   value = "true"
 }
 labels {
   label = "traefik.http.routers.youtube-api.rule"
   value = "Host(`api-vlog.local.brasilhomeoffice.com`)"
 }
 labels {
    label = "traefik.http.routers.youtube-api.entrypoints"
    value = "websecure"
  }
  labels {
    label = "traefik.http.routers.youtube-api.tls"
    value = "true"
  }
 # Redirect to port inside the container
 # because `yarn dev` uses this port
 labels {
   label = "traefik.http.services.youtube-api.loadbalancer.server.port"
   value = "4000"
 }
}



######################################################################
# Database


## Image
resource "docker_image" "youtube-db-image" {
  name = "mariadb:10.5"
  keep_locally = true
  force_remove = false
}

# Container
resource "docker_container" "youtube-db-container" {
  name = "youtube-db"
  image = docker_image.youtube-db-image.latest

  networks_advanced {
    name = docker_network.network.name
  }

  # Environment variables
  env = [
    "MYSQL_ROOT_PASSWORD=root",
    "MYSQL_DATABASE=youtube-db",
    "MYSQL_USER=youtube-db-user",
    "MYSQL_PASSWORD=youtube-db-pass"
  ]

  # Save data locally
  volumes {
    host_path = abspath("../../../storage/youtube-db")
    container_path = "/var/lib/mysql"
  }

  # ---
  # Traefik labels
  labels {
    label = "traefik.enable"
    value = "true"
  }
  labels {
    label = "traefik.tcp.routers.youtube-db.rule"
    value = "HostSNI(`*`)"
  }
  labels {
    label = "traefik.tcp.routers.youtube-db.entrypoints"
    value = "mariadb"
  }
  labels {
    label = "traefik.tcp.services.youtube-db.loadbalancer.server.port"
    value = "3306"
  }
}
