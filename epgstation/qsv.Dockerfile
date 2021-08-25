ARG FFMPEG_VERSION=4.4
ARG EPGSTATION_VERSION=2.6.11

# epgstaion
FROM l3tnun/epgstation:v${EPGSTATION_VERSION}-debian AS epgstation-image


# ffmpeg image
FROM akashisn/ffmpeg:${FFMPEG_VERSION}-qsv AS ffmpeg-image

# Copy artifacts
RUN mkdir /build && \
    cp --archive --parents --no-dereference /usr/local/bin/ff* /build && \
    cp --archive --parents --no-dereference /usr/local/bin/vainfo /build && \
    cp --archive --parents --no-dereference /usr/local/lib/*.so* /build


# final image
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install library
RUN apt-get update && \
    apt-get install -y curl libdrm2 libx11-6 libxext6 libxfixes3 gettext && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Copy from images
COPY --from=epgstation-image /app /app
COPY --from=ffmpeg-image /build /

ENV LIBVA_DRIVERS_PATH=/usr/local/lib \
    LIBVA_DRIVER_NAME=iHD

# ldconfig
RUN ldconfig

EXPOSE 8888
WORKDIR /app
