RAKU    := raku
LIBPATH := lib
QUIET   := -Q
VERBOSE := -v

.PHONY: verbose quiet

default: verbose

verbose:
	RAKULIB=$(LIBPATH) prove $(VERBOSE) --exec=$(RAKU) t/*.t

quiet:
	@ RAKULIB=$(LIBPATH) prove $(QUIET) --exec=$(RAKU) t/*.t
