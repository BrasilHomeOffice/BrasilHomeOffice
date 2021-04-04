# Infra Tips

This is most likely a FAQ.

## How to debug when I ran setup and nothing seems to be running...

```
# Check if container "traefik-container" is UP
docker ps

# Check container logs
docker logs traefik-container

# Check traefik logs
docker exec -ti traefik-container cat /log/traefik.log
```
