FROM ubuntu:22.10

RUN apt-get update && apt-get install -y git make wget bzip2 build-essential pip autoconf cmake supervisor
WORKDIR /home/ubuntu/
RUN git clone -b TasyDevilsky-Docker https://github.com/TasyDevilsky/misp-sighting-server
WORKDIR /home/ubuntu/misp-sighting-server/
RUN git submodule init
RUN git submodule update
WORKDIR /home/ubuntu/misp-sighting-server/back-end/kvrocks
RUN ./x.py build
WORKDIR /home/ubuntu/misp-sighting-server/
RUN pip3 install -r REQUIREMENTS
# To-fix
# RUN ./back-end/kvrocks/build/kvrocks -c back-end/kvrocks/kvrocks.conf&
RUN cp cfg/server.cfg.sample cfg/server.cfg
WORKDIR /home/ubuntu/misp-sighting-server/bin

# Test
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf 

ENTRYPOINT ["/usr/bin/supervisord"]
# Fix
# RUN python3 sighting-server.py



