# Makefile for mod_remoteip.c (gmake)
APXS=$(shell which apxs || which apxs2) 

default: mod_remoteip.o

mod_remoteip.o: mod_remoteip.c
	$(APXS) -c -n mod_remoteip.so mod_remoteip.c

install: mod_remoteip.o
	$(APXS) -i -n mod_remoteip.so mod_remoteip.la

clean:
	rm -rf *~ *.o *.so *.lo *.la *.slo .libs/  build dist

VERSION=$(shell git rev-list HEAD --count 2>/dev/null || echo 0)
NAME=mod_remoteip
# set EXTRAREV to add stuff to the RPM release, .e.g. EXTRAREV=.123 for build number 123
srpm: clean
	mkdir -p dist build/$(NAME)-$(VERSION)
	sed -e 's/__VERSION__/$(VERSION)/' -e 's/__EXTRAREV__/$(EXTRAREV)/' <mod_remoteip.spec >build/mod_remoteip.spec
	mkdir build/$NAME-$VERSION
	cp README LICENSE Makefile mod_remoteip.c mod_remoteip.conf build/$(NAME)-$(VERSION)
	tar -C build -cvzf build/$(NAME)-$(VERSION).tar.gz $(NAME)-$(VERSION)
	rpmbuild --define="_topdir $(CURDIR)/build" --define="_sourcedir $(CURDIR)/build" --define="_srcrpmdir $(CURDIR)/dist" --nodeps -bs build/mod_remoteip.spec
