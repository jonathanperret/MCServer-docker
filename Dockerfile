# Dockerfile to build a MCServer instance.

FROM debian:wheezy

MAINTAINER Alexander Harkness (bearbin)

# Install the required components.
RUN apt-get update && apt-get install -y git gcc g++ cmake make

# Clone the MCServer repository.
RUN git clone https://github.com/mc-server/MCServer.git /mcssrc && \
	cd /mcssrc && git submodule update --init

# Build MCServer
RUN cd /mcssrc && cmake . -DCMAKE_BUILD_TYPE=RELEASE && \
	make && \
	mkdir /mcsbin && \
	cp -r /mcssrc/MCServer/* /mcsbin/ && \
	cd / && rm -rf /mcssrc

# Expose the recommended ports.
EXPOSE 25565 8080

WORKDIR /mcsbin

CMD /mcsbin/MCServer
