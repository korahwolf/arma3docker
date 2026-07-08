#!/bin/sh

doas docker compose down --volumes --remove-orphans
doas docker image prune -a -f
doas docker builder prune -a -f
doas docker system prune -a --volumes -f
