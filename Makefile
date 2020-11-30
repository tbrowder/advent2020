RAKU    := raku
LIBPATH := .
QUIET   := -Q
VERBOSE := -v

.PHONY: quiet verbose

default: quiet

TESTS   := t/*.t

quiet:
	for f in $(TESTS) ; do \
	    RAKULIB=$(LIBPATH) prove $(QUIET) --exec=$(RAKU) $$f ; \
	done

verbose:
	for f in $(TESTS) ; do \
	    RAKULIB=$(LIBPATH) prove $(VERBOSD) --exec=$(RAKU) $$f ; \
	done
