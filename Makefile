TARGETDIR = ~/.config/nvim/lua
DIRNAME = sntm
install:
	cp -rv lua/* ${TARGETDIR}/

uninstall:
	rm -rfv ${TARGETDIR}/${DIRNAME}
