FROM debian:wheezy
MAINTAINER Foo Bar, foo@bar.com

ENV ORG foo
ENV APP bar
ENV INSTALL_DIR /opt/${ORG}/${APP}

ENV PACKAGES wget binutils make csh g++ sed gawk perl zlib1g-dev 
RUN apt-get update -y && apt-get install -y --no-install-recommends ${PACKAGES}

ENV SEQTK https://github.com/avilella/seqtk/archive/sgdp.tar.gz

ENV THIRDPARTY_DIR ${INSTALL_DIR}/thirdparty

RUN mkdir -p ${THIRDPARTY_DIR}
RUN cd ${THIRDPARTY_DIR}

# SEQTK

RUN mkdir -p ${THIRDPARTY_DIR}/seqtk && cd ${THIRDPARTY_DIR}/seqtk &&\
    wget --quiet --no-check-certificate ${SEQTK} --output-document - |\
    tar xzf - --directory . --strip-components=1 && \
    make

# COMPILE HELLO_WORLD

ADD src/hello_world.c ${INSTALL_DIR}/hello_world.c

RUN gcc ${INSTALL_DIR}/hello_world.c -o ${INSTALL_DIR}/hello_world

WORKDIR ${INSTALL_DIR}
ENTRYPOINT ["./hello_world"]

