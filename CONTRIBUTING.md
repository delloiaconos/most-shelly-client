# Contributing to MOST Shelly Client

Thank you for your interest in contributing to the MOST Shelly Client infrastructure project!

## Development Setup

### Prerequisites

Ensure you have the following installed:
- Docker Engine 20.10 or later
- Docker Compose v2.0 or later
- Make (optional, for convenience commands)
- Git

### Getting Started

1. Fork and clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/most-shelly-client.git
cd most-shelly-client
```

2. Create a feature branch:
```bash
git checkout -b feature/your-feature-name
```

3. Make your changes

4. Test your changes:
```bash
# Validate Docker Compose configuration
docker compose config --quiet

# Start services
docker compose up -d

# Check service status
docker compose ps

# View logs
docker compose logs
```

5. Commit and push:
```bash
git add .
git commit -m "Description of your changes"
git push origin feature/your-feature-name
```

6. Create a Pull Request

## Configuration Changes

### Modifying WireGuard Configuration

WireGuard settings are in `docker-compose.yml` under the `wireguard` service environment variables. Common modifications:

- **PEERS**: Increase for more client configurations
- **SERVERURL**: Set to your public IP or domain
- **INTERNAL_SUBNET**: Change the VPN subnet

### Modifying Mosquitto Configuration

Edit `config/mosquitto/mosquitto.conf` for Mosquitto settings. After changes:

```bash
docker compose restart mosquitto
```

## Adding New Services

When adding new services to the infrastructure:

1. Update `docker-compose.yml` with the new service definition
2. Add any necessary configuration files to the `config/` directory
3. Update `.gitignore` if needed to exclude sensitive data
4. Add corresponding Make targets to `Makefile`
5. Update `README.md` with documentation
6. Test thoroughly

## Testing

### Manual Testing

Test WireGuard:
```bash
# Check if WireGuard is running
docker compose ps wireguard

# View generated configs
docker compose logs wireguard
```

Test Mosquitto:
```bash
# Install mosquitto-clients if needed
sudo apt-get install mosquitto-clients

# Subscribe to a topic
mosquitto_sub -h localhost -t test/# -v

# In another terminal, publish
mosquitto_pub -h localhost -t test/hello -m "world"
```

## Code Style

- Use YAML for configuration files
- Use 2-space indentation in YAML files
- Add comments for complex configurations
- Keep configuration organized and readable

## Documentation

- Update README.md for user-facing changes
- Update this file for contributor information
- Use clear, concise language
- Include examples where helpful

## Questions?

Open an issue for questions or discussions about contributions.
