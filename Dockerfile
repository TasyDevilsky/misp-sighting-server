FROM ubuntu:22.10

RUN apt-get update && apt-get install -y git make wget bzip2 build-essential pip autoconf cmake supervisor
WORKDIR /home/ubuntu/

# Use local
COPY  . misp-sighting-server/

# Use external
# RUN git clone -b TasyDevilsky-Docker https://github.com/TasyDevilsky/misp-sighting-server


WORKDIR /home/ubuntu/misp-sighting-server/
RUN git submodule init
RUN git submodule update back-end/kvrocks
WORKDIR /home/ubuntu/misp-sighting-server/back-end/kvrocks
RUN python3 x.py build
WORKDIR /home/ubuntu/misp-sighting-server/
RUN pip3 install -r REQUIREMENTS

RUN cp cfg/server.cfg.sample cfg/server.cfg

# Test
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf 

EXPOSE 5000
ENTRYPOINT ["/usr/bin/supervisord"]

