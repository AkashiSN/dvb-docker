# v4l-utils image
FROM akashisn/v4l-utils AS v4l-utils-image

# final image
FROM debian:buster

ENV GCONV_PATH=/usr/local/lib/gconv

COPY --from=v4l-utils-image / /
COPY ./isdb-init /workdir/isdb-init
COPY ./scan.sh /workdir/scan.sh
COPY ./genConf.py /workdir/genConf.py

RUN apt-get update && \
    apt-get install -y python3 python3-yaml

WORKDIR /workdir
ENTRYPOINT [ "/bin/sh", "/workdir/scan.sh" ]
