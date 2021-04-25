# epgstaion
FROM l3tnun/epgstation AS epgstation-image


# ffmpeg-qsv image
ARG FFMPEG_TYPE=qsv
FROM akashisn/ffmpeg:${FFMPEG_TYPE} AS ffmpeg-qsv-image

# Copy artifacts
RUN mkdir /build && \
    cp --archive --parents --no-dereference /usr/local/bin/ff* /build && \
    cp --archive --parents --no-dereference /usr/local/bin/vainfo /build && \
    cp --archive --parents --no-dereference /usr/local/lib/*.so* /build


# final image
FROM node:14-buster

ENV DEBIAN_FRONTEND=noninteractive

# Copy from images
COPY --from=epgstation-image /app /app
COPY --from=ffmpeg-qsv-image /build /

# Install library
RUN apt-get update && \
    apt-get install -y libdrm2 libx11-6 libxext6 libxfixes3 gettext && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

EXPOSE 8888
WORKDIR /app
