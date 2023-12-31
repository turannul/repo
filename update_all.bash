#!/bin/bash

brew_check(){
    echo "Checking for Homebrew, wget, xz, & zstd..."
    if test ! "$(which brew)"; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    brew list --verbose wget || brew install wget
    brew list --verbose xz || brew install xz
    brew list --verbose zstd || brew install zstd
    clear
    echo "Homebrew checked."
}

apt_ftparchive(){
    echo "Downloading apt-ftparchive..."
    if [ ! -e "apt-ftparchive" ]; then
        wget -q -nc https://apt.procurs.us/apt-ftparchive && sudo chmod 751 ./apt-ftparchive
    fi
    echo "apt-ftparchive downloaded."
}

update_rootless(){
    echo "Updating (rootless) repository..."
    cd rootless/ || exit
    rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release 2> /dev/null
    apt-ftparchive packages ./deb_files > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    bzip2 -c9 Packages > Packages.bz2
    zstd -c19 Packages > Packages.zst
    apt-ftparchive release -c ./config/rootless.conf . > Release
}

update_rootful(){
    echo "Updating (rootful) repository..."
    cd "$(dirname "$0")" || exit
    rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release 2> /dev/null
    apt-ftparchive packages ./deb_files > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    bzip2 -c9 Packages > Packages.bz2
    zstd -c19 Packages > Packages.zst
    apt-ftparchive release -c ./config/rootful.conf . > Release
}


update_rootless_macOS(){
    echo "Updating (rootless) repository..."
    cd rootless/ || exit
    rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release 2> /dev/null
    ./apt-ftparchive packages ./deb_files > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    bzip2 -c9 Packages > Packages.bz2
    zstd -c19 Packages > Packages.zst
    ./apt-ftparchive release -c ./config/rootless.conf . > Release
}

update_rootful_macOS(){
    echo "Updating (rootful) repository..."
    cd "$(dirname "$0")" || exit
    rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release 2> /dev/null
    ./apt-ftparchive packages ./deb_files > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    bzip2 -c9 Packages > Packages.bz2
    zstd -c19 Packages > Packages.zst
    ./apt-ftparchive release -c ./config/rootful.conf . > Release
}

macOS_update_repo(){
    brew_check
    apt_ftparchive
    echo "Update in progress..."
    update_rootful_macOS
    update_rootless_macOS
    echo "Repository Updated."
}

linux_update_repo(){
    echo "Update in progress..."
    update_rootful
    update_rootless
    echo "Repository Updated."
}

if [[ "$OSTYPE" == "linux"* ]]; then
    linux_update_repo
elif [[ "$(uname)" == Darwin ]] && [[ "$(uname -p)" == i386 ]]; then
    macOS_update_repo
fi
