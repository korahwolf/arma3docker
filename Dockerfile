FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive


RUN dpkg --add-architecture i386 \
	&& apt update \
	&& apt install -y lib32gcc-s1 curl ca-certificates net-tools \
	&& rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 steam \
    && useradd -m -u 1000 -g 1000 steam

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER steam

RUN mkdir -p /home/steam/steamcmd
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - -C /home/steam/steamcmd
RUN chmod +x /home/steam/steamcmd/steamcmd.sh
