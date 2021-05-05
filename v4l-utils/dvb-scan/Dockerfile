# v4l-utils image
FROM akashisn/v4l-utils AS v4l-utils-image

# final image
FROM debian:buster

ENV GCONV_PATH=/usr/local/lib/gconv

COPY --from=v4l-utils-image / /
COPY ./isdb-init /workdir/isdb-init
COPY ./scan.sh /workdir/scan.sh

# ldconfig
RUN ldconfig

WORKDIR /workdir
ENTRYPOINT [ "/bin/sh", "/workdir/scan.sh" ]
