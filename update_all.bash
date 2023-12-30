#!/bin/bash
if [[ "$OSTYPE" == "linux"* ]]; then
    linux_update_repo
elif [[ "$(uname)" == Darwin ]] && [[ "$(uname -p)" == i386 ]]; then
    macOS_update_repo
fi

macOS_update_repo(){
    echo "Checking for Homebrew, wget, xz, & zstd..."
    if test ! "$(which brew)"; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    brew list --verbose wget || brew install wget
    brew list --verbose xz || brew install xz
    brew list --verbose zstd || brew install zstd
    echo "Downloading apt-ftparchive..."
    if [ ! -e "apt-ftparchive" ]; then
        wget -q -nc https://apt.procurs.us/apt-ftparchive && sudo chmod 751 ./apt-ftparchive
    fi
    rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release 2> /dev/null
    rm rootless/Packages rootless/Packages.xz rootless/Packages.gz rootless/Packages.bz2 rootless/Packages.zst rootless/Release 2> /dev/null
    echo "Updating repository..."
    ./apt-ftparchive packages ./deb_files > Packages
    ./apt-ftparchive packages ./deb_files_rootless > rootless/Packages
    ./apt-ftparchive release -c ./repo/repo.conf . > Release
    ./apt-ftparchive release -c ./rootless/repo/repo.conf . > rootless/Release
    echo "Repository Update successful, compressing files..."
    gzip -c9 Packages > Packages.gz
    gzip -c9 rootless/Packages > rootless/Packages.gz
    xz -c9 Packages > Packages.xz
    xz -c9 rootless/Packages > rootless/Packages.xz
    bzip2 -c9 Packages > Packages.bz2
    bzip2 -c9 rootless/Packages > rootless/Packages.bz2
    zstd -c19 Packages > Packages.zst
    zstd -c19 rootless/Packages > rootless/Packages.zst 
    echo "Repository Updated."
}


linux_update_repo(){
    echo "Updating repository..."
    rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release 2> /dev/null
    rm rootless/Packages rootless/Packages.xz rootless/Packages.gz rootless/Packages.bz2 rootless/Packages.zst rootless/Release 2> /dev/null

    apt-ftparchive packages ./deb_files > Packages
    apt-ftparchive packages ./deb_files_rootless > rootless/Packages
    apt-ftparchive release -c ./repo/repo.conf . > Release
    apt-ftparchive release -c ./rootless/repo/repo.conf . > rootless/Release

    gzip -c9 Packages > Packages.gz
    gzip -c9 rootless/Packages > rootless/Packages.gz
    xz -c9 Packages > Packages.xz
    xz -c9 rootless/Packages > rootless/Packages.xz
    bzip2 -c9 Packages > Packages.bz2
    bzip2 -c9 rootless/Packages > rootless/Packages.bz2
    zstd -c19 Packages > Packages.zst
    zstd -c19 rootless/Packages > rootless/Packages.zst
    echo "Repository Updated."
}