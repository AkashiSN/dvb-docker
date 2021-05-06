# Mirakurun image
FROM chinachu/mirakurun AS mirakurun-image


# libarib25 image
FROM akashisn/libarib25 AS libarib25-image


# v4l-utils image
FROM akashisn/v4l-utils AS v4l-utils-image


# final image
FROM node:14-buster

ENV DEBIAN_FRONTEND=noninteractive
ENV GCONV_PATH=/usr/local/lib/gconv
WORKDIR /app

# Install library
RUN apt-get update && \
    apt-get install -y pcscd pcsc-tools libccid libpcsclite1 && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Copy from images
COPY --from=mirakurun-image /app /app
COPY --from=libarib25-image / /
COPY --from=v4l-utils-image / /

# Copy init script
COPY ./container-init.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/container-init.sh

# ldconfig
RUN ldconfig

EXPOSE 40772 9229
ENTRYPOINT ["/usr/local/bin/container-init.sh"]