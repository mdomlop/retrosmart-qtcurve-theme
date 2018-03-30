PREFIX='/usr'
DESTDIR=''

PROGRAM_NAME := $(shell grep ^PROGRAM_NAME INFO | cut -d\= -f2)
EXECUTABLE_NAME := $(shell grep ^EXECUTABLE_NAME INFO | cut -d\= -f2)
DESCRIPTION := $(shell grep ^DESCRIPTION INFO | cut -d\= -f2)
VERSION := $(shell grep ^VERSION INFO | cut -d\= -f2)
AUTHOR := $(shell grep ^AUTHOR INFO | cut -d\= -f2)
MAIL := $(shell grep ^MAIL INFO | cut -d\= -f2)
LICENSE := $(shell grep ^LICENSE INFO | cut -d\= -f2)
TIMESTAMP = $(shell LC_ALL=C date '+%a, %d %b %Y %T %z'))

ChangeLog: changelog.in
	@echo "$(EXECUTABLE_NAME) ($(VERSION)) unstable; urgency=medium" > $@
	@echo >> $@
	@echo "  * Git build." >> $@
	@echo >> $@
	@echo " -- $(AUTHOR) <$(MAIL)>  $(TIMESTAMP)" >> $@
	@echo >> $@
	@cat $^ >> $@

install: src/Retrosmart.qtcurve
	install -dm 755 $(DESTDIR)/$(PREFIX)/share/QtCurve
	install -m 644 $^ $(DESTDIR)/$(PREFIX)/share/QtCurve/
	install -Dm644 LICENSE $(DESTDIR)/$(PREFIX)/share/licenses/$(EXECUTABLE_NAME)/LICENSE
	install -Dm644 AUTHORS $(DESTDIR)/$(PREFIX)/share/doc/$(EXECUTABLE_NAME)/AUTHORS
	install -Dm644 ChangeLog $(DESTDIR)/$(PREFIX)/share/doc/$(EXECUTABLE_NAME)/ChangeLog
	install -Dm644 README.md $(DESTDIR)/$(PREFIX)/share/doc/$(EXECUTABLE_NAME)/README

uninstall:
	rm -f $(PREFIX)/$(PREFIX)/share/QtCurve/Retrosmart/
	rm -f $(PREFIX)/share/licenses/$(EXECUTABLE_NAME)/
	rm -rf $(PREFIX)/share/doc/$(EXECUTABLE_NAME)/

clean:
	rm -rf *.xz *.gz *.pot po/*.mo *.tgz *.deb *.rpm ChangeLog /tmp/tmp.*.$(EXECUTABLE_NAME) debian/changelog debian/README debian/files debian/$(EXECUTABLE_NAME) debian/debhelper-build-stamp debian/$(EXECUTABLE_NAME)* pkg

dpkg: ChangeLog
	cp README.md debian/README
	cp ChangeLog debian/changelog
	#fakeroot debian/rules clean
	#fakeroot debian/rules build
	fakeroot debian/rules binary
	mv ../$(EXECUTABLE_NAME)_$(VERSION)_all.deb .
	@echo Package done!
	@echo You can install it as root with:
	@echo dpkg -i $(EXECUTABLE_NAME)_$(VERSION)_all.deb

pacman: clean
	sed -i "s|pkgver=.*|pkgver=$(VERSION)|" PKGBUILD
	makepkg -e
	@echo Package done!
	@echo You can install it as root with:
	@echo pacman -U $(EXECUTABLE_NAME)-local-$(VERSION)-1-any.pkg.tar.xz
