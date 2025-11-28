# Jellyfin Media Stack

A complete Docker Compose stack for automated media management and streaming using Jellyfin and the *arr suite.

## 🌟 Features

- **Dedicated IP Addresses**: Uses macvlan networking to assign each container its own IP address, avoiding port conflicts
- **Complete Media Automation**: Integrated downloading, organizing, and streaming workflow
- **Easy Setup**: Automated directory creation with included script
- **Modular Design**: Each service runs in its own container for easy management

## 📦 Services Included

| Service | Description | Default Port |
|---------|-------------|--------------|
| [Jellyfin](https://jellyfin.org/) | Media server for streaming your content | 8096 |
| [Sonarr](https://sonarr.tv/) | TV show management and automation | 8989 |
| [Radarr](https://radarr.video/) | Movie management and automation | 7878 |
| [Prowlarr](https://prowlarr.com/) | Indexer manager for *arr apps | 9696 |
| [qBittorrent](https://www.qbittorrent.org/) | Torrent client | 8080 |
| [Requestrr](https://github.com/darkalfx/requestrr) | Chatbot for Discord/Telegram media requests | 4545 |

## 📋 Prerequisites

- **Docker** - [Install Docker](https://docs.docker.com/engine/install/)
- **Docker Compose** - [Install Docker Compose](https://docs.docker.com/compose/install/)
- **Linux Server/Host** - Ubuntu, Debian, or similar
- **Storage Space** - Adequate storage for your media library
- **Network Knowledge** - Understanding of your network's subnet and gateway

## 🚀 Installation

### Step 1: Identify Your Network Adapter

First, identify your network adapter name using one of these commands:

```bash
ifconfig -a
```

OR

```bash
ip link show
```

OR

```bash
ip a
```

Look for your primary network interface (typically `eth0`, `ens18`, `enp0s3`, etc.)

### Step 2: Create macvlan Network

Create a Docker macvlan network with your network configuration:

```bash
docker network create -d macvlan \
  --subnet=[YOUR_SUBNET] \
  --gateway=[YOUR_GATEWAY_IP] \
  -o parent=[YOUR_NETWORK_ADAPTER] \
  mediamacvlan
```

**Example:**
```bash
docker network create -d macvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  -o parent=eth0 \
  mediamacvlan
```

### Step 3: Set Up Directory Structure

Create a parent directory for the media stack:

```bash
mkdir ~/mediastack
cd ~/mediastack
```

Clone this repository:

```bash
git clone https://github.com/gkmayn/jellyfinmediastack.git .
```

Make the directory creation script executable:

```bash
chmod +x directory.sh
```

Run the script to create all necessary directories:

```bash
./directory.sh
```

The script will create the required directory structure and display the paths.

### Step 4: Configure Docker Compose

Edit the `docker-compose.yml` file:

```bash
nano docker-compose.yml
```

Update the following:
- **IP Addresses**: Assign static IPs to each container within your subnet
- **Volume Mappings**: Verify the paths match those created by `directory.sh`
- **Timezone**: Set your timezone (e.g., `TZ=America/New_York`)
- **PUID/PGID**: Set to match your user (run `id` to find these values)

### Step 5: Deploy the Stack

Start all containers:

```bash
sudo docker-compose up -d
```

Verify containers are running:

```bash
sudo docker-compose ps
```

## 🔧 Configuration

### Initial Setup Order

1. **Prowlarr** - Configure indexers first
2. **Sonarr/Radarr** - Connect to Prowlarr for indexers
3. **qBittorrent** - Set download paths
4. **Sonarr/Radarr** - Configure qBittorrent as download client
5. **Jellyfin** - Add media libraries
6. **Requestrr** - Connect to Sonarr/Radarr

### Accessing Services

If you assigned IPs starting from `192.168.1.100`:

- Jellyfin: `http://192.168.1.100:8096`
- Sonarr: `http://192.168.1.101:8989`
- Radarr: `http://192.168.1.102:7878`
- Prowlarr: `http://192.168.1.103:9696`
- qBittorrent: `http://192.168.1.104:8080`
- Requestrr: `http://192.168.1.105:4545`

*(Adjust IPs based on your configuration)*

## 📁 Directory Structure

The `directory.sh` script creates the following structure:

```
mediastack/
├── config/
│   ├── jellyfin/
│   ├── sonarr/
│   ├── radarr/
│   ├── prowlarr/
│   ├── qbittorrent/
│   └── requestrr/
├── media/
│   ├── movies/
│   ├── tv/
│   └── downloads/
└── docker-compose.yml
```

## 🛠️ Management

### Start the stack
```bash
sudo docker-compose up -d
```

### Stop the stack
```bash
sudo docker-compose down
```

### View logs
```bash
sudo docker-compose logs -f [service_name]
```

### Restart a specific service
```bash
sudo docker-compose restart [service_name]
```

### Update containers
```bash
sudo docker-compose pull
sudo docker-compose up -d
```

## 🐛 Troubleshooting

### Container can't access network
- Verify macvlan network exists: `docker network ls`
- Check IP addresses don't conflict with existing devices
- Ensure subnet and gateway are correct

### Permission denied errors
- Check PUID/PGID in docker-compose.yml
- Verify directory permissions: `ls -la`
- May need to run: `sudo chown -R $USER:$USER ./config ./media`

### Can't access services
- Verify containers are running: `docker-compose ps`
- Check firewall rules
- Ensure IPs are accessible from your network

### Containers keep restarting
- Check logs: `docker-compose logs [service_name]`
- Verify volume paths exist
- Check for port conflicts

## 📝 Notes

- **Volumes**: This setup creates volumes outside the compose file for better control over storage and permissions
- **Network Isolation**: Each container gets its own IP, making it easier to manage firewall rules and avoid port conflicts
- **Customization**: You can add or remove services by editing the docker-compose.yml file

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- [Jellyfin](https://jellyfin.org/) - The free software media system
- [Sonarr](https://sonarr.tv/) - Smart PVR for newsgroup and bittorrent users
- [Radarr](https://radarr.video/) - Movie collection manager
- [Prowlarr](https://prowlarr.com/) - Indexer manager/proxy
- [qBittorrent](https://www.qbittorrent.org/) - Open-source BitTorrent client

## 📧 Support

If you have questions or need help:
- Open an [Issue](https://github.com/gkmayn/jellyfinmediastack/issues)
- Check existing issues for solutions
- Review the documentation for each service

---

**⚠️ Disclaimer**: This stack is for managing your personal media library. Ensure you comply with all applicable laws and terms of service when downloading content.
