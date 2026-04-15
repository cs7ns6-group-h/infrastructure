#!/usr/bin/env bash
# Start only the EU region stack + shared infra (Zookeeper, Postgres).
# Skips US/APAC Kafka, Cassandra, Redis, and all non-EU apps.
#
# Usage:
#   ./start-eu-only.sh           # default compose resources
#   ./start-eu-only.sh --lite    # merge docker-compose.eu-lite.yml (smaller heaps)
#
set -euo pipefail
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$SCRIPT_DIR"

LITE=false
if [[ "${1:-}" == "--lite" ]]; then
  LITE=true
fi

compose_args=(-f docker-compose.yml)
if [[ "$LITE" == true ]]; then
  compose_args+=(-f docker-compose.eu-lite.yml)
fi

docker compose "${compose_args[@]}" up -d \
  zookeeper \
  kafka-eu \
  cassandra-eu \
  redis-eu \
  postgres \
  iam-eu \
  journey-booking-eu \
  traffic-compatibility-eu \
  notification-eu \
  enforcement-eu

echo "EU stack is up."
echo "  journey-booking-eu       -> http://localhost:8001"
echo "  traffic-compatibility-eu -> http://localhost:8002"
echo "  notification-eu          -> http://localhost:8003"
echo "  enforcement-eu           -> http://localhost:8004"
echo "  iam-eu                   -> http://localhost:8005"
