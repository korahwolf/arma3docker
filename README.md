# arma3docker
arma3docker is a Docker container that sets up a dedicated server for Arma 3.

## features
- adjustment of server config (server.cfg)
- downloading and updating of workshop mods

## dependencies
- docker
- docker compose

## build and run
- clone the repository with `git clone https://github.com/korahwolf/arma3docker --depth 1`
- navigate into the repo with `cd arma3docker`
- adjust the server configuration and change the passwords in `armaconfig/server.cfg`
- add your desired workshop mods in `armaconfig/workshop_ids.txt`
- `STEAM_USER` and `STEAM_PASS` set in `.env`
- if rootless docker is not set up, the `armafiles` folder needs to be created and its permissions need to be corrected with `mkdir armafiles && chown -R 1000:1000 armafiles`
- run the container with `docker compose up`

## important
- the `clean.sh` script can be used to wipe the container and everything associated with it except for the mounts
