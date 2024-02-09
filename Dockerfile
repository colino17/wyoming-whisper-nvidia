# BASE IMAGE
FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu20.04

# ENVIRONMENT VARIABLES
ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu
ENV MODEL=medium-int8
ENV BEAM_SIZE=5
ENV LANGUAGE=en

# INSTALL WHISPER
WORKDIR /usr/src
ARG WHISPER_VERSION='1.0.1'

RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        python3 \
        python3-dev \
        python3-pip \
        nano \
    \
    && pip3 install --no-cache-dir -U \
        setuptools \
        wheel \
    && pip3 install --no-cache-dir \
        --extra-index-url https://www.piwheels.org/simple \
        "wyoming-faster-whisper==${WHISPER_VERSION}" \
    \
    && apt-get purge -y --auto-remove \
        build-essential \
        python3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /
COPY run.sh ./

# EXPOSE PORTS
EXPOSE 10300

# ENTRYPOINT COMMAND
ENTRYPOINT ["bash", "/run.sh"]
