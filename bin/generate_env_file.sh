#!/bin/bash
set -euo pipefail

cat <<EOF
COMPOSE_UID=$(id -u)
COMPOSE_GID=$(id -g)
WEBSSH_SECRET_KEY=
WEBSSH_ALLOW_DIALOG=false
EOF
