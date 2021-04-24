# mirakurun-build
FROM akashisn/buildenv:ubuntu-20.04 AS mirakurun-build

# Install dependency
RUN apt-get update && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

ENV DOCKER="YES"

# Install mirakurun
RUN npm install mirakurun -g --unsafe-perm --production


# libarib25 image
FROM akashisn/libarib25 AS libarib25-image


# v4l-utils image
FROM akashisn/v4l-utils AS v4l-utils-image


# final image
FROM ubuntu:20.04

WORKDIR /app

# Copy from images
COPY --from=mirakurun-build /usr/local/lib/node_modules/mirakurun /app
COPY --from=libarib25-image /build /
COPY --from=v4l-utils-image /build /

# Copy init script
COPY ./container-init.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/container-init.sh

# Install node and library
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y pcscd pcsc-tools libccid libpcsclite1 && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

EXPOSE 40772 9229
ENTRYPOINT ["/usr/local/bin/container-init.sh"]