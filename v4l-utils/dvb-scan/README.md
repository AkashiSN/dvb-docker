# dvb-scan

## Manual scan

```bash
docker run --rm -it \
  --device /dev/dvb:/dev/dvb \
  --cap-add SYS_ADMIN \
  --cap-add SYS_NICE \
  -v `pwd`/tuners:/workdir/tuners ghcr.io/akashisn/dvb-scan
```
