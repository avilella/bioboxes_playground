FROM debian:wheezy
MAINTAINER Foo Bar, foo@bar.com

ENV PACKAGES wget binutils make csh g++ sed gawk zlib1g-dev
RUN apt-get update -y && apt-get install -y --no-install-recommends ${PACKAGES}

ENV HTSLIB https://github.com/samtools/htslib/archive/1.2.tar.gz
ENV BCFTOOLS https://github.com/samtools/bcftools/archive/1.2.tar.gz

ENV THIRDPARTY_DIR /opt/bioboxes/toolkit/thirdparty

RUN mkdir -p ${THIRDPARTY_DIR}
RUN cd ${THIRDPARTY_DIR}

# HTSLIB

RUN cd ${THIRDPARTY_DIR} &&\
    wget --quiet --no-check-certificate ${HTSLIB} --output-document - |\
    tar xzf - --directory htslib --strip-components=1 && \
    cd htslib && \
    make install

# BCFTOOLS

RUN cd ${THIRDPARTY_DIR} &&\
    wget --quiet --no-check-certificate ${BCFTOOLS} --output-document - |\
    tar xzf - --directory bcftools --strip-components=1 && \
    cd bcftools && \
    make install

# ENTRYPOINT ["run"]
