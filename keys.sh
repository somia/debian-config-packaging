do_keys() {
	if [ -d ${PACKAGE_DIR}/usr/share/keyrings ]
	then
		for FILENAME in $(cd ${PACKAGE_DIR}/usr/share/keyrings && ls -1 *.gpg)
		do echo -e "\t\tapt-key $1 /usr/share/keyrings/$FILENAME"
		done
	fi
}
