FROM buildpack-deps:buster AS arib25-build

ENV DEBIAN_FRONTEND=noninteractive

# Install dependency
RUN apt-get update && \
    apt-get install -y cmake libpcsclite-dev

# Download libarib25
ADD https://github.com/stz2012/libarib25/archive/master.tar.gz /tmp/libarib25-master.tar.gz

# Build patched libarib25
RUN tar xf /tmp/libarib25-master.tar.gz -C /tmp/ && \
    cd /tmp/libarib25-master && \
    cmake -DCMAKE_BUILD_TYPE=Release -DLDCONFIG_EXECUTABLE=IGNORE . && \
    make -j$(nproc) && \
    make install

# Copy wrapper script
COPY ./arib-b25-stream /usr/local/bin/
RUN chmod 755 /usr/local/bin/arib-b25-stream

# Copy artifacts
RUN mkdir /build && \
    cp --archive --parents --no-dereference /usr/local/bin/ /build && \
    cp --archive --parents --no-dereference /usr/local/lib/ /build && \
    cp --archive --parents --no-dereference /usr/local/include/ /build && \
    rm -r /build/usr/local/lib/python*

# final image
FROM scratch

COPY --from=arib25-build /build /
