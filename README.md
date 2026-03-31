# infrastructure – CS7NS6 Group H

This repository contains the Docker Compose setup to run the full
distributed traffic service locally, simulating three geographic regions
(EU, US, APAC) using isolated Docker networks.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/) installed
- Access to the GitHub Container Registry (ghcr.io) — log in once with:

```bash
echo $GITHUB_TOKEN | docker login ghcr.io -u YOUR_GITHUB_USERNAME --password-stdin
```

## Setup

```bash
# 1. Clone this repo
git clone https://github.com/cs7ns6-group-h/infrastructure.git
cd infrastructure

# 2. Create your .env file

# 3. Pull all images and start everything
docker compose pull
docker compose up -d

# 4. Check all services are running
docker compose ps
```

## Services and Ports

| Service | EU | US | APAC |
|---|---|---|---|
| Journey Booking | 8001 | 8011 | 8021 |
| Traffic/Compatibility | 8002 | 8012 | 8022 |
| Notification | 8003 | 8013 | 8023 |
| Enforcement | 8004 | 8014 | 8024 |
| IAM | 8005 | 8015 | 8025 |

## Failure Scenario Scripts

```bash
# Simulate Cassandra node failure (EU)
docker compose stop cassandra-eu

# Restore it
docker compose start cassandra-eu

# Simulate Kafka broker failure (US)
docker compose stop kafka-us

# Simulate entire region failure (APAC)
docker compose stop kafka-apac cassandra-apac redis-apac \
  journey-booking-apac traffic-compatibility-apac \
  notification-apac enforcement-apac iam-apac
```

## Stopping everything

```bash
docker compose down

# To also remove volumes (wipe all data):
docker compose down -v
```

## Architecture

See the [docs](https://github.com/cs7ns6-group-h/docs) repository for
the full system architecture report and diagrams.