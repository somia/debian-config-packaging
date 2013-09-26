cat <<EOF
inside_chroot() {
	if ! mountpoint -q /proc || [ "`readlink /proc/self/root`" != "/" ]
	then
		return 0
	else
		return 1
	fi
}

log() {
	if inside_chroot
	then
		echo "${PACKAGE_NAME}: \$@" \${REDIRECT}
	else
		echo "${PACKAGE_NAME}: \$@" \${REDIRECT} | logger
	fi
}

service_restart() {
	if inside_chroot
	then
		log "INFO: not starting service \$1 in chroot environment"
		return 0
	else
		service \$1 restart
		ret=\$?

		if [ \$ret -eq 0 ]
		then log "INFO: service \$1 restarted"
		else log "ERROR: service \$1 restart failed"
		fi

		return \$ret
	fi
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
