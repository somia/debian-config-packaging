SOURCE_NAME	?= $(notdir $(PWD))
PACKAGE_DIRS	?= $(filter-out debian,$(shell git ls-files -- */ | cut -d/ -f1 | sort -u))

build:: $(patsubst %,build-%,$(PACKAGE_DIRS))

build-%::
	$(MAKE) -f debian/package.mk SOURCE_NAME=$(SOURCE_NAME) PACKAGE_DIR=$(@:build-%=%)

clean::
	rm -rf build
