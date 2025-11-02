# most-shelly-client
MOST Spoke 5 - Shelly client infrastructure

## Overview

This repository contains a simple, self-contained Docker Compose stack designed to quickly deploy a private WireGuard VPN endpoint and a small, internal service network.

### Key Features
- **Secure Networking**: Deploys the wireguard service, exposing a single UDP port (50002) to the host for secure remote access.
- **Isolated Private Subnet**: Establishes the private wg_net ($192.168.125.0/24$), ensuring all internal services are reachable only through the VPN tunnel.
- **Service Testing**: Includes a basic whoami-srv container to confirm network connectivity and routing once a WireGuard client is connected.
- **Configuration Persistence**: WireGuard configuration files (keys and peers) are persistently stored on the host system at /opt/most-shelly/wireguard. 

This setup is ideal for creating a lightweight, dedicated VPN access point to a local network or a cloud server.

## Running 

Make sure the external network ```most_net``` already exists:

```bash
docker network create most_net
```

Then you can bring up the stack:
```bash
docker-compose -p mostsheylly up -d
```

or you can use:

```bash
export COMPOSE_PROJECT_NAME=mostsheylly
docker-compose up -d
```

To stop and remove containers and networks, including volumes:

```bash
docker-compose down -v
```


If you used a custom project name (```mostsheylly```):
```bash
docker-compose -p mostsheylly down -v
```

## Some utility commands


# Git & Collaboration
This project is version-controlled via Git for clarity and development hygiene — no CI/CD or advanced Git-based deployments are planned.
If you'd like access to the repository, just ask the maintainer.

# Fundings
This study was carried out within the MOST - Sustainable Mobility National Research Center and received funding from the European Union Next-GenerationEU (PIANO NAZIONALE DI RIPRESA E RESILIENZA (PNRR) - MISSIONE 4 COMPONENTE 2, INVESTIMENTO 1.4 - D.D. 1033 17/06/2022, CN00000023), Spoke 5 "Light Vehicle and Active Mobility". 
This work/code/repository reflects only the authors’ views and opinions, neither the European Union nor the European Commission can be considered responsible for them.
