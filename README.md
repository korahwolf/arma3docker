# arma3docker
arma3docker is a Docker container that sets up a dedicated server for Arma 3.

## features
- adjustment of server config (server.cfg)
- downloading and updating of workshop mods

## dependencies
- docker
- docker compose

## build
- clone the repository with `git clone https://github.com/korahwolf/arma3docker --depth 1`
- navigate into the repo with `cd arma3docker`
- adjust the server configuration and change the passwords in `armaconfig/server.cfg`
- add your desired workshop mods in `armaconfig/workshop_ids.txt`
- set `STEAM_USER` and `STEAM_PASS` in `.env`
- run the container with `docker compose up`

## additional tips
- the `clean.sh` script can be used to wipe the container and everything associated with it except for the mounts
