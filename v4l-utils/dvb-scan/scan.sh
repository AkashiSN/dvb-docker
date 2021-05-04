#!/bin/sh
set -eu

dvbv5-scan -C JP -a 1 -o /workdir/tuners/isdbt.conf /workdir/isdb-initial/jp-ISDBT-ALL
dvbv5-scan -C JP -a 0 -N -T 5 -o /workdir/tuners/isdbs-bs.conf /workdir/isdb-initial/jp-ISDBS-BS
dvbv5-scan -C JP -a 0 -N -T 5 -o /workdir/tuners/isdbs-cs.conf /workdir/isdb-initial/jp-ISDBS-CS

cat /workdir/tuners/isdbt.conf /workdir/tuners/isdbs-bs.conf /workdir/tuners/isdbs-cs.conf > /workdir/tuners/isdb-all.conf
