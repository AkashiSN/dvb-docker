ARG FFMPEG_VERSION=5.0
ARG EPGSTATION_VERSION=2.6.20

# epgstation
FROM l3tnun/epgstation:v${EPGSTATION_VERSION}-debian AS epgstation-image


# ffmpeg image
FROM akashisn/ffmpeg:${FFMPEG_VERSION} AS ffmpeg-image

# Copy artifacts
RUN mkdir /build && \
    cp --archive --parents --no-dereference /usr/local/bin/ff* /build


# final image
FROM ubuntu:20.04 AS epgstation

ENV DEBIAN_FRONTEND=noninteractive

# Install library
RUN apt-get update && \
    apt-get install -y curl gettext socat && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Copy from images
COPY --from=epgstation-image /app /app
COPY --from=ffmpeg-image /build /

EXPOSE 8888
WORKDIR /app
