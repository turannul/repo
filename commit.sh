#! /bin/bash
# Filza da kullanmak için, Terminali normal (nonSuperuser) olarak #ayarlayın.
cd /private/var/mobile/Documents/Github/repo
git pull
/var/mobile/Documents/Github/repo/updaterepo.sh
git add /private/var/mobile/Documents/Github/repo
git commit -a -m "Something is new?" 
git push
