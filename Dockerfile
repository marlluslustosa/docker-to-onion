# Based on Debian-slim (minimal)
1FROM debian:buster-slim

# Maintainer
LABEL maintainer "Marllus Lustosa <marlluslustosa@riseup.net>"

# http://label-schema.org/rc1/
LABEL org.label-schema.schema-version "1.0"
LABEL org.label-schema.name           "docker-to-onion"
LABEL org.label-schema.description    "Expose local docker as onion service"
LABEL org.label-schema.vcs-url        "https://github.com/marlluslustosa/docker-to-onion"

RUN apt-get update && \
    apt-get upgrade -y &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    ntpdate \
    build-essential \
    libssl-dev \
    tor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Compile shallot
ADD ./shallot /shallot

RUN cd /shallot && \
    ./configure && \
    make && \
    mv ./shallot /bin && \
    cd / && \
    rm -Rf /shallot && \
    apt-get -y purge build-essential libssl-dev && \
    rm -Rf /var/lib/apt/lists/*

RUN useradd --system --uid 666 -M --shell /usr/sbin/nologin tor

COPY main.sh /

RUN mkdir /web && \
    chown -R tor /web /etc/tor && \
    chmod 700 /web

VOLUME /web

USER tor

ENTRYPOINT ["/main.sh"]
