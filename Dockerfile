#syntax=docker/dockerfile:1.2

FROM crops/yocto:ubuntu-20.04-base

USER root

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y python3-pip vim lz4 zstd \
    && pip3 install kas

USER yoctouser

COPY --chown=yoctouser:yoctouser . /home/yoctouser/amora

WORKDIR /home/yoctouser/amora

SHELL ["/bin/bash", "-c"] 

ARG KAS_TARGET=""
ENV KAS_TARGET=$KAS_TARGET
RUN KAS_TARGET=$KAS_TARGET ./scripts/build.sh

# At this point you can copy files to host if needed
