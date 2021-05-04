# epgstaion
FROM l3tnun/epgstation AS epgstation-image


# ffmpeg image
FROM akashisn/ffmpeg AS ffmpeg-image

# Copy artifacts
RUN mkdir /build && \
    cp --archive --parents --no-dereference /usr/local/bin/ff* /build


# final image
FROM node:14-buster

ENV DEBIAN_FRONTEND=noninteractive

# Copy from images
COPY --from=epgstation-image /app /app
COPY --from=ffmpeg-image /build /

# Install library
RUN apt-get update && \
    apt-get install -y gettext sudo && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

EXPOSE 8888
WORKDIR /app
