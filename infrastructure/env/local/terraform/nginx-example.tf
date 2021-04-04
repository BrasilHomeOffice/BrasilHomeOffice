# # This file was created to expose nginx
# # And the only thing you need to in order
# # to remove nginx completely
# # is to remove this file
# 
# # Image
# resource "docker_image" "nginx-example-image" {
#   name = "nginx"
#   keep_locally = true
#   force_remove = true
# }
# 
# # Container
# resource "docker_container" "nginx-example-container" {
#   name = "nginx-example-container"
#   image = docker_image.nginx-example-image.latest
#   tty = true
# 
#   networks_advanced {
#     name = docker_network.network.name
#   }
# 
#   # ---
#   # Traefik labels
#   labels {
#     label = "traefik.enable"
#     value = "true"
#   }
#   labels {
#     label = "traefik.http.routers.nginx-example.rule"
#     value = "Host(`local.brasilhomeoffice.com`)"
#   }
#   labels {
#     label = "traefik.http.routers.nginx-example.entrypoints"
#     value = "web"
#   }
# }
# 