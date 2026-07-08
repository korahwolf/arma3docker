# arma3docker
arma3docker is a Docker container that sets up a dedicated server for Arma 3.

## features
- adjustment of server config (server.cfg)
- installing, updating and deletion of workshop mods

## dependencies
- docker
- docker compose

## running
- create an empty folder and navigate into it
- download [docker-compose.yml](https://github.com/korahwolf/arma3docker/blob/main/docker-compose.yml)
- create a folder called `config` that holds an empty file `workshop_ids.txt` and the example [server.cfg](https://github.com/korahwolf/arma3docker/blob/main/config/server.cfg)
- set `STEAM_USER` and `STEAM_PASS` in a `.env` file
- run `docker compose up` (as superuser if needed)

## building
- clone the repository with `git clone https://github.com/korahwolf/arma3docker --depth 1`
- run `docker build .`
