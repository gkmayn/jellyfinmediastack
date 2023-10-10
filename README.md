# Automated JellyFin Stack 🤖📽️

Docker Compose Stack for Jellyfin Automation:

- Allows you to place each docker container on its own IP using macvlan to avoid conflicts and statically assign IPs

Requirements:

- Docker
- Docker-compose
- Storage Space for Media
- Linux server/host

Containers:

- Jellyfin
- Sonarr
- Radarr
- Requestrr
- Prowlarr
- Qbittorrent

# Finding the Parent Network Adapter:

```
ifconfig -a
```
OR
```
ip link show
```
OR
```
ip a
```

# Creating the macvlan:

```
$ docker network create -d macvlan \
    --subnet=[SUBNET] \
    --gateway=[GATEWAY IP]  \
    -o parent=[NETWORK ADAPTER] \
     mediamacvlan
```

# Creating the mapped volumes:

I choose to create the volumes outside of the compose file so I have better control over the storage and file permissions.

I have created a script, 'directory.sh', that will create the necessary directories and print out the paths for them in the terminal. (Only use this if you want to have the directories in the same drive/storage!)

1. Create a parent directory for these mappings to live in:

```
$ mkdir mediastack
```

```
$ cd mediastack
```

2. Clone the repo into the 'mediastack' directory:

```
$ git clone [REPO]
```

3. Make the script executable by running (May need to use 'sudo'):

```
$ chmod +x directory.sh
```

4. Run the Script:

```
$ ./directory.sh
```

# Creating the stack:

After editing the compose file with nano/vim/etc. to include your assigned IP addresses & mappings, create the stack using the below:

```
$ sudo docker-compose up -d
```
