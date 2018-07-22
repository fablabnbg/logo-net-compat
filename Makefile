#
# Makefile for logo-net-compat
#

dist:
	cd deb && sh ./dist.sh

install: logo-net-compat.sh
	install -D -T $< /lib/udev/logo-net-compat.sh
	sh -x $< start

uninstall: logo-net-compat.sh
	/lib/udev/logo-net-compat.sh stop
	rm -f /lib/udev/logo-net-compat.sh

