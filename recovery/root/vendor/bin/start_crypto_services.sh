#!/sbin/sh

log_file="/tmp/recovery.log"

log_print() {
    echo "I:start_crypto_services.sh: $1" | tee -a "$log_file"
}

wait_for_service() {
	i=0
	while [ "$i" -lt 30 ]; do
		if [ "$(getprop init.svc."$1")" = "$2" ]; then
			return 0
		fi
		sleep 1
		i=$((i + 1))
	done
	log_print "$1 did not reach state $2."
	return 1
}

# The HAL reads the version properties in its constructor and hands them to the
# TA, so it is left disabled until they match the installed system. Start it
# even when they could not be read: keystore2 blocks until KeyMint registers,
# and nothing decrypts without it.
start_crypto_services() {
    ab_device=$(getprop ro.build.ab_update)

    if [ -n "$ab_device" ]; then
    	log_print "A/B device detected! Finding current boot slot..."
    	suffix=$(getprop ro.boot.slot_suffix)
    	if [ -z "$suffix" ]; then
    		suf=$(getprop ro.boot.slot)
    		if [ -n "$suf" ]; then
    			suffix="_$suf"
    		fi
    	fi
    	log_print "Current boot slot: $suffix"
    fi

	boot_path="/dev/block/bootdevice/by-name/boot${suffix}"

	if [ -e "$boot_path" ]; then
		boot_osver=$(strings -n 2 "$boot_path" | awk '/com.android.build.boot.os_version/{getline; print; exit}')
		boot_patch=$(strings -n 2 "$boot_path" | awk '/com.android.build.boot.security_patch/{getline; print; exit}')
		if [ -n "$boot_osver" ]; then
			resetprop ro.bootimage.build.version.release "$boot_osver"
			log_print "Stock boot OS version: $boot_osver"
		fi
		if [ -n "$boot_patch" ]; then
			resetprop ro.bootimage.build.version.security_patch "$boot_patch"
			log_print "Stock boot security patch: $boot_patch"
		fi
	fi

    log_print "Starting KeyMint..."
	setprop ctl.start vendor.keymint-qti
	wait_for_service vendor.keymint-qti running
}

start_crypto_services
