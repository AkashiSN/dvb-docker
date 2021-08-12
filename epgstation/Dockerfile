ARG FFMPEG_VERSION=4.4
ARG EPGSTATION_VERSION=2.6.7

# epgstaion
FROM l3tnun/epgstation:v${EPGSTATION_VERSION}-debian AS epgstation-image


# ffmpeg image
FROM akashisn/ffmpeg:${FFMPEG_VERSION} AS ffmpeg-image

# Copy artifacts
RUN mkdir /build && \
    cp --archive --parents --no-dereference /usr/local/bin/ff* /build


# final image
FROM node:16-buster

ENV DEBIAN_FRONTEND=noninteractive

# Install library
RUN apt-get update && \
    apt-get install -y gettext sudo && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Copy from images
COPY --from=epgstation-image /app /app
COPY --from=ffmpeg-image /build /

# ldconfig
RUN ldconfig

EXPOSE 8888
WORKDIR /app
