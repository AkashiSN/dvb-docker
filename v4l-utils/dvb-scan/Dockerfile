FROM akashisn/v4l-utils:ubuntu AS v4l-utils

FROM ubuntu:20.04

ENV GCONV_PATH=/usr/local/lib/gconv

COPY --from=v4l-utils /build /
COPY ./isdb-initial /workdir/isdb-init
COPY ./scan.sh /workdir/scan.sh

WORKDIR /workdir
ENTRYPOINT [ "/bin/sh" "/workdir/scan.sh" ]
