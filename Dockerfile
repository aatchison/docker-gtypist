FROM ubuntu:latest

RUN apt-get update

RUN apt-get install -y build-essential \
    curl \
    ncurses-dev

WORKDIR /src

RUN curl  https://ftp.gnu.org/gnu/gtypist/gtypist-2.9.tar.xz -o gtypist.tar.xz
RUN tar xvf gtypist.tar.xz

WORKDIR /src/gtypist-2.9

RUN ls -al


RUN curl "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD" -o config.guess

RUN ls -al

RUN ./configure

RUN make

RUN make install

RUN apt-get remove -y build-essential \
    curl \
    ncurses-dev

# clean up repositories
RUN apt-get clean autoclean
RUN apt-get autoremove -y
RUN rm -Rf /var/lib/{apt,dpkg,cache,log}/


RUN useradd myuser -d /home/myuser
RUN usermod -aG sudo,myuser myuser

USER myuser

CMD ["gtypist"]