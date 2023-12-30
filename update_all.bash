#!/bin/bash

# Check if apt-ftparchive exists
if [ ! -e "apt-ftparchive" ]; then
    wget -q -nc https://apt.procurs.us/apt-ftparchive && sudo chmod 751 ./apt-ftparchive
fi

rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release 2> /dev/null
rm rootless/Packages rootless/Packages.xz rootless/Packages.gz rootless/Packages.bz2 rootless/Packages.zst rootless/Release 2> /dev/null

./apt-ftparchive packages ./deb_files > Packages
./apt-ftparchive packages ./deb_files_rootless > rootless/Packages
./apt-ftparchive release -c ./repo/repo.conf . > Release
./apt-ftparchive release -c ./rootless/repo/repo.conf . > rootless/Release

gzip -c9 Packages > Packages.gz
gzip -c9 rootless/Packages > rootless/Packages.gz
xz -c9 Packages > Packages.xz
xz -c9 rootless/Packages > rootless/Packages.xz
bzip2 -c9 Packages > Packages.bz2
bzip2 -c9 rootless/Packages > rootless/Packages.bz2
zstd -c19 Packages > Packages.zst
zstd -c19 rootless/Packages > rootless/Packages.zst
