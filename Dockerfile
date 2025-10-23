FROM ubuntu:latest

# Allow specifying a specific version, otherwise fetch the latest
ARG GTYPIST_VERSION=latest

RUN apt-get update && \
    apt-get install -y build-essential \
    curl \
    ncurses-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /src

# Dynamically fetch the latest gtypist version or use specified version
RUN if [ "$GTYPIST_VERSION" = "latest" ]; then \
        GTYPIST_VERSION=$(curl -s https://ftp.gnu.org/gnu/gtypist/ | \
        grep -oP 'gtypist-\K[0-9.]+(?=\.tar\.xz)' | \
        sort -V | tail -1); \
    fi && \
    echo "Building gtypist version: $GTYPIST_VERSION" && \
    curl -L "https://ftp.gnu.org/gnu/gtypist/gtypist-${GTYPIST_VERSION}.tar.xz" -o gtypist.tar.xz && \
    tar xf gtypist.tar.xz && \
    rm gtypist.tar.xz && \
    cd gtypist-${GTYPIST_VERSION} && \
    ./configure && \
    make && \
    make install

WORKDIR /

RUN apt-get remove -y build-essential curl ncurses-dev && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /src

RUN useradd -m -d /home/myuser myuser

USER myuser

WORKDIR /home/myuser

CMD ["gtypist"]