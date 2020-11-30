RAKU    := raku
LIBPATH := lib
QUIET   := -Q
VERBOSE := -v

.PHONY: santa

default: santa

#TESTS   := t/*.t

santa:
	@ RAKULIB=$(LIBPATH) prove $(QUIET) --exec=$(RAKU) t/santa/*.t


verbose:
	RAKULIB=$(LIBPATH) prove $(VERBOSE) --exec=$(RAKU) t/santa/*.t
