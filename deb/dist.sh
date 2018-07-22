#! /bin/bash
# Make a debian/ubuntu distribution
#
# sudo apt-get install checkinstall fakeroot

name=logo-net-compat
vers=$(date +%Y%m%d)
rel=1
url=http://github.com/fablabnbg/logo-net-compat
requires="bash"

fakeroot checkinstall --fstrans --reset-uid --type debian --install=no -y --arch all --pakdir ../out --deldoc \
  --pkgname $name \
  --pkgversion $vers \
  --pkgrelease $rel \
  --pkglicense MIT \
  --pkggroup other \
  --pkgsource $url \
  --exclude /etc/sysconfig/network \
  --pkgaltsource "http://fablab-nuernberg.de" \
  --maintainer "'Juergen Weigert (juergen@fabmail.org)'" \
  --requires "'$requires'" \
  make -C .. install || { echo "error"; exit 1; }

cd ..
for deb in out/*.deb; do
  test -f $deb && (set -x; dpkg-deb -I $deb; dpkg-deb -c $deb)
done
