# Makefile for mod_remoteip.c (gmake)
APXS=$(shell which apxs || which apxs2) 

default: mod_remoteip.la

mod_remoteip.la: mod_remoteip.c
	$(APXS) -c -n mod_remoteip.so mod_remoteip.c

install: mod_remoteip.la
	$(APXS) -i -n mod_remoteip.so mod_remoteip.la

clean:
	rm -rf *~ *.o *.so *.lo *.la *.slo .libs/ 
