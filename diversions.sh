cat <<EOF
diversion_add() {
	if [ ! -e \$1.diverted-by-${PACKAGE_NAME} ]
	then dpkg-divert --package ${PACKAGE_NAME} --divert \$1.diverted-by-${PACKAGE_NAME} --rename \$1
	fi
}

diversion_remove() {
	if [ -e \$1.diverted-by-${PACKAGE_NAME} ]
	then dpkg-divert --package ${PACKAGE_NAME} --rename --remove \$1
	fi
}

EOF

do_diversions() {
	if [ -e ${PACKAGE_DIR}/diverts ]
	then sed -r "$1" ${PACKAGE_DIR}/diverts
	fi
}
