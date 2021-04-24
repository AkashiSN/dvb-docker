# v4l-utils

## Use by multi stage build

```Dockerfile
FROM akashisn/v4l-utils:ubuntu AS v4l-utils

FROM ubuntu:20.04
COPY --from=v4l-utils /build /
```