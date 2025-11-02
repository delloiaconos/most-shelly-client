# most-shelly-client
MOST Spoke 5 - Shelly client infrastructure



## Overview


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
