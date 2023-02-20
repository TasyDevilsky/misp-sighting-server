FROM ubuntu:lunar

RUN apt-get update && apt-get install -y git make wget bzip2 build-essential pip autoconf cmake
WORKDIR /home/ubuntu/
RUN git clone https://github.com/TasyDevilsky/misp-sighting-server
WORKDIR /home/ubuntu/misp-sighting-server/
RUN git submodule init
RUN git submodule update
WORKDIR /home/ubuntu/misp-sighting-server/back-end/kvrocks
RUN ./x.py build
WORKDIR /home/ubuntu/misp-sighting-server/
RUN pip3 install -r REQUIREMENTS
RUN ./back-end/kvrocks/build/kvrocks -c back-end/kvrocks/kvrocks.conf&
RUN cp cfg/server.cfg.sample cfg/server.cfg
WORKDIR /home/ubuntu/misp-sighting-server/bin
RUN python3 sighting-server.py



