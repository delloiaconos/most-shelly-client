# most-shelly-client
MOST Spoke 5 - Shelly client infrastructure

## Overview

This repository contains the Docker Compose infrastructure for running:
- **WireGuard VPN Server**: Secure VPN access to the infrastructure
- **Mosquitto MQTT Broker**: Message broker for IoT device communication

> 🚀 **New to this project?** Check out the [Quick Start Guide](QUICKSTART.md) to get up and running in under 5 minutes!

## Prerequisites

- Docker Engine 20.10 or later
- Docker Compose v2.0 or later
- Linux host with kernel WireGuard support (or WireGuard kernel module)

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/delloiaconos/most-shelly-client.git
cd most-shelly-client
```

2. Start the services:
```bash
docker-compose up -d
```

3. Check the status:
```bash
docker-compose ps
```

## Services

### WireGuard VPN Server

**Container Name**: `wireguard`  
**Image**: `linuxserver/wireguard:latest`  
**Port**: `51820/udp`

The WireGuard server provides secure VPN access to the infrastructure. Client configurations are automatically generated on first startup.

#### Accessing Client Configurations

After the first startup, WireGuard will generate client configuration files. To view the QR code for easy mobile setup:

```bash
docker-compose logs wireguard
```

Or access the configuration files directly:
```bash
docker-compose exec wireguard cat /config/peer1/peer1.conf
```

To display a QR code for mobile clients:
```bash
docker-compose exec wireguard cat /config/peer1/peer1.png
```

#### Configuration

WireGuard settings can be modified in `docker-compose.yml` under the `wireguard` service:
- `SERVERURL`: The public IP or domain name of your server (default: auto-detected)
- `SERVERPORT`: The port for WireGuard (default: 51820)
- `PEERS`: Number of client configurations to generate (default: 1)
- `INTERNAL_SUBNET`: Internal VPN subnet (default: 10.13.13.0)

### Mosquitto MQTT Broker

**Container Name**: `mosquitto`  
**Image**: `eclipse-mosquitto:latest`  
**Ports**: 
- `1883`: MQTT protocol
- `9001`: WebSockets

The Mosquitto broker handles MQTT messaging for IoT devices and clients.

#### Testing the MQTT Broker

Using mosquitto_pub and mosquitto_sub (install mosquitto-clients):

```bash
# Subscribe to a test topic
mosquitto_sub -h localhost -t test/topic

# In another terminal, publish a message
mosquitto_pub -h localhost -t test/topic -m "Hello MQTT"
```

#### Configuration

The Mosquitto configuration is located at `config/mosquitto/mosquitto.conf`. 

**Important Security Note**: By default, anonymous connections are allowed for easy setup. For production use, you should:
1. Disable anonymous access
2. Configure authentication (username/password or certificates)
3. Set up access control lists (ACLs)

To modify the configuration:
1. Edit `config/mosquitto/mosquitto.conf`
2. Restart the service: `docker-compose restart mosquitto`

## Directory Structure

```
most-shelly-client/
├── docker-compose.yml          # Main Docker Compose configuration
├── config/
│   ├── mosquitto/
│   │   └── mosquitto.conf      # Mosquitto broker configuration
│   └── wireguard/              # WireGuard configs (auto-generated)
└── data/
    └── mosquitto/              # Mosquitto persistent data
        ├── data/               # Message persistence
        └── log/                # Log files
```

## Management Commands

### Using Make (Recommended)

A Makefile is provided for convenient service management:

```bash
# Show all available commands
make help

# Start services
make up

# Stop services
make down

# Restart services
make restart

# View logs
make logs                # All services
make logs-wireguard      # WireGuard only
make logs-mosquitto      # Mosquitto only

# Show status
make status

# Update services
make update              # Pull latest images and restart

# WireGuard helpers
make wireguard-config    # Show peer configuration
make wireguard-qr        # Show QR code for mobile setup

# Mosquitto testing (requires mosquitto-clients)
make mosquitto-test-sub  # Subscribe to test topic
make mosquitto-test-pub  # Publish test message
```

### Using Docker Compose Directly

### Start services
```bash
docker-compose up -d
```

### Stop services
```bash
docker-compose down
```

### View logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f wireguard
docker-compose logs -f mosquitto
```

### Restart a service
```bash
docker-compose restart wireguard
docker-compose restart mosquitto
```

### Update images
```bash
docker-compose pull
docker-compose up -d
```

## Network Architecture

Both services run on a shared Docker bridge network (`most-network`), allowing them to communicate internally. Services can reference each other by their container names.

## Security Considerations

1. **WireGuard**: 
   - Keep client configuration files secure
   - Regularly rotate keys for compromised peers
   - Limit the number of peers to only necessary clients

2. **Mosquitto**:
   - Change `allow_anonymous true` to `false` in production
   - Implement authentication mechanisms
   - Use TLS/SSL for encrypted connections
   - Configure ACLs to restrict topic access

## Troubleshooting

### WireGuard not starting

Ensure your kernel has WireGuard support:
```bash
sudo modprobe wireguard
```

Check logs:
```bash
docker-compose logs wireguard
```

### Mosquitto connection refused

Verify the service is running:
```bash
docker-compose ps mosquitto
```

Check if port is accessible:
```bash
netstat -tuln | grep 1883
```

### Permissions issues

Ensure proper ownership of data directories:
```bash
sudo chown -R 1000:1000 data/
```

## License

This project is part of the MOST (Monitoring Open Source Technologies) initiative.
