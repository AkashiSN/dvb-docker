#!/bin/sh
set -eu

rm -f ./tuners/*.conf

dvbv5-scan -C JP -a 0 -o ./tuners/isdbt-uhf.conf ./isdb-init/jp-ISDBT-UHF
dvbv5-scan -C JP -a 1 -N -T 5 -o ./tuners/isdbs-bs.conf ./isdb-init/jp-ISDBS-BS
dvbv5-scan -C JP -a 1 -N -T 5 -o ./tuners/isdbs-cs.conf ./isdb-init/jp-ISDBS-CS

echo "# UHF" > ./tuners/isdb.conf
cat ./tuners/isdbt-uhf.conf >> ./tuners/isdb.conf

if [ -f ./tuners/isdbs-bs.conf ]; then
  sed -i -e 's/DVBS/ISDBS/g' ./tuners/isdbs-bs.conf
  echo "# BS" >> ./tuners/isdb.conf
  cat ./tuners/isdbs-bs.conf >> ./tuners/isdb.conf
fi

if [ -f ./tuners/isdbs-cs.conf ]; then
  sed -i -e 's/DVBS/ISDBS/g' ./tuners/isdbs-cs.conf
  echo "# CS" >> ./tuners/isdb.conf
  cat ./tuners/isdbs-cs.conf >> ./tuners/isdb.conf
fi

echo "Saved channel conf in ./tuners/isdb.conf"

python3 genConf.py ./tuners/isdbt-uhf.conf ./tuners/isdbs-bs.conf ./tuners/isdbs-cs.conf ./tuners/channels.yml

echo "Saved mirakurun channel conf in ./tuners/channels.yml"
