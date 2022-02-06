#! /opt/procursus/bin/bash
# sign.sh # Commands creates public and secret key #
gpg -abs -u 085B6CCD035FF7906623E04AE59C6432536DF4E2 -o Release.gpg Release #<-- Public Key
gpg --export 085B6CCD035FF7906623E04AE59C6432536DF4E2 > turannul-repo.gpg #<-- Secret Key
#For some reason on unc0ver jailbreak you can't create #the keys
