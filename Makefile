# Makefile for mod_remoteip.c (gmake)
APXS=$(shell which apxs || which apxs2) 

check:
	ifeq ($(APXS),)
		$(error apxs not found. Please install apxs)
	endif

default: mod_remoteip.o check

mod_remoteip.o: mod_remoteip.c
	$(APXS) -c -n mod_remoteip.so mod_remoteip.c

install: mod_remoteip.o
	$(APXS) -i -n mod_remoteip.so mod_remoteip.la

clean:
	rm -rf *~ *.o *.so *.lo *.la *.slo .libs/ 
