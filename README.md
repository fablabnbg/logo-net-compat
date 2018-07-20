# logo-net-compat

The LOGO software expects thes config files in the openSUSE style.
This script is a workaround to make the LOGO software work also on
popular Ubuntu and Debian systems.

We refresh empty files in /etc/sysconfig/network/ifcfg-* to have
exactly one per active network interface.
This immitates the config files as seen in openSUSE.

Usage:

Install this script to /lib/udev/logo-net-compat.sh, then run

    /lib/udev/logo-net-compat.sh start

to create the corresponding udev rule and run it once.
to populate (empty!) ifcfg-* files into /etc/sysconfig/network

    /lib/udev/logo-net-compat.sh stop

to remove the udev rule and remove empty files in /etc/sysconfig/network

