# Automated JellyFin Stack

Docker Compose Stack for Jellyfin Automation:

- Allows you to place each docker container on its own IP using macvlan to avoid conflicts and statically assign IPs


# Creating the macvlan:

```
$ docker network create -d macvlan \
    --subnet=[SUBNET] \
    --gateway=[GATEWAY IP]  \
    -o parent=[NETWORK ADAPTER] \
     [MACVLAN NAME]
```

