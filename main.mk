SOURCE_NAME	?= $(notdir $(PWD))
PACKAGE_DIRS	?= $(filter-out debian packages,$(shell git ls-files -- */ | cut -d/ -f1 | grep -Fv . | sort -u))

build:: $(patsubst %,build-%,$(PACKAGE_DIRS))

build-%::
	@ test ! -e $(@:build-%=%)/Makefile || $(MAKE) -C $(@:build-%=%)
	@ $(MAKE) -f debian/package.mk -s SOURCE_NAME=$(SOURCE_NAME) PACKAGE_DIR=$(@:build-%=%)

clean::
	rm -rf build
