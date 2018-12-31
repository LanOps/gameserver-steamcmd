FROM ubuntu:16.04
MAINTAINER Thornton Phillis (Th0rn0@lamops.co.uk)

# Install, update & upgrade packages
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y \
        lib32stdc++6 \
        lib32gcc1 \
        lib32tinfo5 \
        libncurses5 \
        libncurses5:i386 \
        libc6:i386 \
        libstdc++6:i386 \
        lib32z1 \
        libcurl3-gnutls:i386 \
        curl && \
        apt-get -y upgrade && \
        apt-get clean autoclean && \
        apt-get autoremove -y && \
        rm -rf /var/lib/{apt,dpkg,cache,log}

# Switch to user steam
RUN useradd -m steam
USER steam

# SteamCMD
RUN mkdir -p /home/steam/steamcmd && cd /home/steam/steamcmd && \
        curl -o steamcmd_linux.tar.gz "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" && \
        tar zxf steamcmd_linux.tar.gz && \
        rm steamcmd_linux.tar.gz

RUN mkdir -p /home/steam/.steam/sdk32 &&\
    ln -s /home/steam/steamcmd/linux32/steamclient.so /home/steam/.steam/sdk32/steamclient.so

WORKDIR /home/steam

RUN /home/steam/steamcmd/steamcmd.sh +login anonymous +quit
