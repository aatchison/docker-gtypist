FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y build-essential \
    curl \
    ncurses-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /src

RUN curl -L https://ftp.gnu.org/gnu/gtypist/gtypist-2.10.1.tar.xz -o gtypist.tar.xz && \
    tar xf gtypist.tar.xz && \
    rm gtypist.tar.xz

WORKDIR /src/gtypist-2.10.1

RUN ./configure && \
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