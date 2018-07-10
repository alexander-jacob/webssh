#!/bin/bash
set -euo pipefail

cat <<EOF
COMPOSE_UID=$(id -u)
COMPOSE_GID=$(id -g)

IMG=registry.jacob-consulting.de/o2/webssh
EOF
