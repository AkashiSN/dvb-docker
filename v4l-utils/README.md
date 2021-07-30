# v4l-utils

[![v4l-utils](https://github.com/AkashiSN/dvb-docker/actions/workflows/v4l-utils.yml/badge.svg)](https://github.com/AkashiSN/dvb-docker/actions/workflows/v4l-utils.yml)

## Use by multi stage build

```Dockerfile
FROM ghcr.io/akashisn/dvb-docker/v4l-utils AS v4l-utils

FROM ubuntu:20.04
COPY --from=v4l-utils /build /
```