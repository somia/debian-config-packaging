PACKAGE_NAME	:= $(SOURCE_NAME)-$(PACKAGE_DIR)
PACKAGE_COMMIT	:= $(shell git log -1 --pretty=format:%H -- $(PACKAGE_DIR))
PACKAGE_VERSION	:= $(shell git describe --tags --long $(PACKAGE_COMMIT) | sed s/-/./)
PACKAGE_FILE	:= build/$(PACKAGE_NAME)_$(PACKAGE_VERSION)_all.deb

$(PACKAGE_FILE): $(find $(PACKAGE_DIR) -not -type d)
	rm -rf build/$(PACKAGE_DIR)
	mkdir -p build/$(PACKAGE_DIR)/debian
	cp -r debian/. build/$(PACKAGE_DIR)/debian/
	cd build/$(PACKAGE_DIR) && fakeroot debian/rules binary SOURCE_NAME=$(SOURCE_NAME) PACKAGE_NAME=$(PACKAGE_NAME) PACKAGE_DIR=../../$(PACKAGE_DIR) PACKAGE_COMMIT=$(PACKAGE_COMMIT) PACKAGE_VERSION=$(PACKAGE_VERSION)
	ln -sf $(PACKAGE_NAME)_$(PACKAGE_VERSION)_all.deb build/$(PACKAGE_NAME).deb
