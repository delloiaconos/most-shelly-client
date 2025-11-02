# Quick Start Guide

Get the MOST Shelly Client infrastructure running in under 5 minutes!

## Prerequisites Check

```bash
# Check Docker
docker --version
# Should show: Docker version 20.10 or later

# Check Docker Compose
docker compose version
# Should show: Docker Compose version v2.0 or later

# Check if WireGuard module is available (Linux only)
lsmod | grep wireguard || sudo modprobe wireguard
```

## 1. Clone and Navigate

```bash
git clone https://github.com/delloiaconos/most-shelly-client.git
cd most-shelly-client
```

## 2. Start Services

```bash
# Using Make (recommended)
make up

# OR using Docker Compose directly
docker compose up -d
```

## 3. Verify Services

```bash
# Check status
make status

# OR
docker compose ps
```

You should see both services running:
- wireguard (port 51820/udp)
- mosquitto (ports 1883, 9001)

## 4. Access WireGuard VPN

### Get the Configuration

```bash
# View configuration
make wireguard-config

# OR show QR code for mobile
make wireguard-qr
```

### Connect a Client

**Desktop (Linux/Mac/Windows):**
1. Install WireGuard client from https://www.wireguard.com/install/
2. Copy the peer1.conf content
3. Import into WireGuard client
4. Connect!

**Mobile (iOS/Android):**
1. Install WireGuard app from your app store
2. Scan the QR code shown by `make wireguard-qr`
3. Connect!

## 5. Test MQTT Broker

### Install Testing Tools (if needed)

```bash
# Ubuntu/Debian
sudo apt-get install mosquitto-clients

# macOS
brew install mosquitto

# Windows (using WSL or Git Bash)
# Download from https://mosquitto.org/download/
```

### Subscribe to Messages

```bash
# In terminal 1
make mosquitto-test-sub

# OR
mosquitto_sub -h localhost -t test/topic -v
```

### Publish a Message

```bash
# In terminal 2
make mosquitto-test-pub

# OR
mosquitto_pub -h localhost -t test/topic -m "Hello MQTT!"
```

You should see the message appear in terminal 1! 🎉

## Next Steps

### View Logs

```bash
# All services
make logs

# Just WireGuard
make logs-wireguard

# Just Mosquitto
make logs-mosquitto
```

### Stop Services

```bash
make down
```

### Customize Configuration

1. Copy the example environment file:
```bash
cp .env.example .env
```

2. Edit `.env` with your settings

3. Restart services:
```bash
make restart
```

### Advanced Configuration

See the full [README.md](README.md) for:
- Security configuration
- Production deployment
- Custom settings
- Troubleshooting

## Common Issues

### WireGuard won't start

**Problem**: `wireguard exited (1)`

**Solution**: Ensure WireGuard kernel module is loaded:
```bash
sudo modprobe wireguard
lsmod | grep wireguard
```

### Mosquitto connection refused

**Problem**: Can't connect to port 1883

**Solution**: Check if the service is running:
```bash
docker compose ps mosquitto
docker compose logs mosquitto
```

### Permission denied errors

**Problem**: Permission errors in logs

**Solution**: Fix data directory permissions:
```bash
sudo chown -R 1000:1000 data/
```

## Getting Help

- Check the [README.md](README.md) for detailed documentation
- See [CONTRIBUTING.md](CONTRIBUTING.md) for development information
- Open an issue on GitHub for support

---

**That's it!** You now have a working WireGuard VPN and MQTT broker infrastructure! 🚀
