# most-shelly-client
MOST Spoke 5 - Shelly client infrastructure

## Overview

This repository defines the MOST Shelly Client environment, integrating a WireGuard VPN and an MQTT broker (Eclipse Mosquitto).
It provides secure, network-isolated communication between services using two Docker networks — one shared (most_net) and one private VPN subnet (wg_net).

### Architecture
| Service        | Image                     | Purpose                                                                                                                                 |
| -------------- | ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| **wireguard**  | `procustodibus/wireguard` | Provides a secure VPN tunnel for remote Shelly devices or external nodes. Runs on `wg_net` with a fixed IP.                             |
| **mqtt**       | `eclipse-mosquitto:2.0`   | MQTT message broker for data exchange between Shelly clients and MOST components. Connected to both networks (`wg_net` and `most_net`). |
| **whoami-srv** | `jwilder/whoami`          | Lightweight HTTP test container for verifying WireGuard connectivity.                                                                   |


### Key Components
| Setting                | Description                                                                             |
| ---------------------- | --------------------------------------------------------------------------------------- |
| **Static IPs**         | WireGuard → `192.168.125.125`, MQTT → `192.168.125.125`, Whoami → `192.168.125.3`       |
| **Persistent volumes** | Data and configuration for Mosquitto and WireGuard are stored under `/opt/most-shelly/` |
| **Time sync**          | Each container mounts `/etc/localtime` to stay aligned with the host timezone           |
| **Restart policy**     | All containers restart automatically unless manually stopped                            |


### Directory Structure

```bash
/opt/most-shelly/
│
├── wireguard/
│   └── wg0.conf
└── mosquitto/
    ├── config/
    │   └── mosquitto.conf
    └── data/
```

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
