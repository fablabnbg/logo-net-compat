#! /bin/sh
#
# logo-net-compat.sh
# (C) 2018 Juergen Weigert <juergen@fabmail.org>
# Distrbute under GPL-2.0 or ask.
#
# The LOGO software expects these config files in the openSUSE style. 
# This script is a workaround to make the LOGO software work also on
# popular Ubuntu and Debian systems.
#
# We refresh empty files in /etc/sysconfig/network/ifcfg-* to have 
# exactly one per active network interface.
# This immitates the config files as seen in openSUSE.
#
# Usage:
#
# Install this script to /lib/udev/logo-net-compat.sh, then run
# /lib/udev/logo-net-compat.sh start	
# 	to create the corresponding udev rule and run it once.
# /lib/udev/logo-net-compat.sh stop	
# 	to remove the udev rule and remove empty files in $netdir

udevfile=/lib/udev/rules.d/98-logo-net-compat.rules
if [ "$1" = 'start' ]; then
  echo "ACTION=\"add|remove\", SUBSYSTEM==\"net\", PROGRAM=\"$0\"" > $udevfile
fi

# make sure the folder exists
netdir=/etc/sysconfig/network
mkdir -p $netdir
# carefully remove empty files only, so that we don't remove real config files, if any.
find $netdir -maxdepth 1 -size 0 | xargs rm -f

if [ "$1" = 'stop' ]; then
  rm -f $udevfile
  exit 0
fi

# create (again) those files that should exist.
for dev in $(ls /sys/class/net); do 
  test $dev = 'lo' && continue; 
  touch $netdir/ifcg-$dev
done

