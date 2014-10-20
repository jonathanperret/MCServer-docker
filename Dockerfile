# Dockerfile to build a MCServer instance.

FROM debian:wheezy

MAINTAINER Alexander Harkness (bearbin)

# Make sure the container is updated.
RUN apt-get update && apt-get upgrade -y

# Install basic tools
RUN apt-get install -y tar nano wget

# Install the required components.
RUN apt-get install -y git gcc g++ cmake make

# Clone the MCServer repository.
RUN git clone https://github.com/mc-server/MCServer.git /mcssrc
RUN cd /mcssrc && git submodule update --init

# Build MCServer
RUN cd /mcssrc && cmake . -DCMAKE_BUILD_TYPE=RELEASE && make -j 2

RUN mkdir /mcsbin && cp -r /mcssrc/MCServer/* /mcsbin/

# Expose the recommended ports.
EXPOSE 25565 8080

WORKDIR /mcsbin

CMD /mcsbin/MCServer
