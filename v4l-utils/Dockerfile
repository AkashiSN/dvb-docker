FROM buildpack-deps:buster AS v4l-build

ENV DEBIAN_FRONTEND=noninteractive

# Install dependency
RUN apt-get update && \
    apt-get install -y gettext autopoint udev libudev-dev systemd libelf-dev

# Download v4l-utils
ADD https://linuxtv.org/downloads/v4l-utils/v4l-utils-1.22.1.tar.bz2 /tmp/

# Build patched v4l-utils
RUN tar xf /tmp/v4l-utils-1.22.1.tar.bz2 -C /tmp/ && \
    cd /tmp/v4l-utils-1.22.1 && \
    ./bootstrap.sh && \
    ./configure --disable-doxygen-doc --disable-doxygen-dot --disable-v4l2-compliance-libv4l \
        --disable-v4l2-ctl-libv4l --disable-qv4l2 --enable-gconv --enable-shared && \
    make -j$(nproc) CFLAGS="-fPIC" && \
    make install

# Build gconv
RUN cd /tmp/v4l-utils-1.22.1/contrib/gconv && \
    make install

# Copy artifacts
RUN mkdir /build && \
    cp --archive --parents --no-dereference /usr/local/bin/ /build && \
    cp --archive --parents --no-dereference /usr/local/lib/ /build && \
    cp --archive --parents --no-dereference /usr/local/include/ /build && \
    rm -r /build/usr/local/lib/python*

# final image
FROM scratch

COPY --from=v4l-build /build /
