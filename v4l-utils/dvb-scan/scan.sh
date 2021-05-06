#!/bin/sh
set -eu

dvbv5-scan -C JP -a 0 -o /workdir/tuners/isdbt-uhf.conf /workdir/isdb-init/jp-ISDBT-UHF
dvbv5-scan -C JP -a 1 -N -T 5 -o /workdir/tuners/isdbs-bs.conf /workdir/isdb-init/jp-ISDBS-BS
dvbv5-scan -C JP -a 1 -N -T 5 -o /workdir/tuners/isdbs-cs.conf /workdir/isdb-init/jp-ISDBS-CS

echo "# UHF" > /workdir/tuners/isdb.conf
cat /workdir/tuners/isdbt-uhf.conf >> /workdir/tuners/isdb.conf
echo "# BS" >> /workdir/tuners/isdb.conf
cat /workdir/tuners/isdbs-bs.conf >> /workdir/tuners/isdb.conf
echo "# CS" >> /workdir/tuners/isdb.conf
cat /workdir/tuners/isdbs-cs.conf >> /workdir/tuners/isdb.conf

echo "Saved channel conf in ./tuners/isdb.conf"