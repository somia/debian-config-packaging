cat <<EOF
log() {
	echo "${PACKAGE_NAME}: \$@" | logger
}

service_restart() {
	service \$1 restart
	ret=\$?

	if [ \$ret -eq 0 ]
	then log "INFO: service \$1 restarted"
	else log "ERROR: service \$1 restart failed"
	fi

	return \$ret
}

service_manual() {
	log "INFO: service \$1 may need to be restarted manually"
}

EOF

do_services() {
	if [ -e ${PACKAGE_DIR}/services ]
	then sed -r "s,^([^[:space:]]+)[[:space:]]+([^[:space:]]+),\t\tservice_\2 \1," ${PACKAGE_DIR}/services
	fi
}
