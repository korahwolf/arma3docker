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
- if rootless docker is not set up, the `armafiles` and `armaconfig` folders must be created and set to be owned by `1000:1000`
- `armaconfig` must contain at least `server.cfg` and `workshop_ids.txt` before the container runs, even if they're empty
- run the container with `docker compose up`
