#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2020-2021 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="m2461"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then 
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	export LC_ALL="C"
	export FOX_AB_DEVICE=1
	export OF_AB_DEVICE_WITH_RECOVERY_PARTITION=1
	export OF_RECOVERY_AB_FULL_REFLASH_RAMDISK=1
	export OF_USE_LZ4_COMPRESSION=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_LZ4_BINARY=1
	export FOX_USE_ZSTD_BINARY=1
	export FOX_USE_DATE_BINARY=1
	export OF_TWRP_COMPATIBILITY_MODE=1
	export OF_NO_RELOAD_AFTER_DECRYPTION=1
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	export FOX_DELETE_AROMAFM=1
	export OF_USE_GREEN_LED=0
	export TARGET_DEVICE_ALT="meizu21"
	export FOX_VANILLA_BUILD=1
	export OF_NO_MIUI_PATCH_WARNING=1
	export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
	export OF_QUICK_BACKUP_LIST="/init_boot;/vendor_boot;/recovery;/persist;/super;"
	export FOX_USE_GREP_BINARY=1
	export FOX_USE_BUSYBOX_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export OF_FORCE_PREBUILT_KERNEL=1
	export OF_ENABLE_LPTOOLS=1
	export OF_ENABLE_ALL_PARTITION_TOOLS=1
	export FOX_VIRTUAL_AB_DEVICE=1
	export OF_DYNAMIC_FULL_SIZE=9663676416
	export OF_DEFAULT_TIMEZONE="TAIST-8;TAIDT"
	export OF_ENABLE_FS_COMPRESSION=1
	export OF_DISPLAY_FORMAT_FILESYSTEMS_DEBUG_INFO=1
	export FOX_SETTINGS_ROOT_DIRECTORY=/mzlogfs
	export FOX_ALLOW_EARLY_SETTINGS_LOAD=1
	export OF_UNBIND_SDCARD_F2FS=1
	export OF_WIPE_METADATA_AFTER_DATAFORMAT=1
	export FOX_USE_UPDATED_MAGISKBOOT=1
	export OF_FORCE_DATA_FORMAT_F2FS=1
	export FOX_MOVE_MAGISK_INSTALLER_TO_RAMDISK=1
	export FOX_USE_FSCK_EROFS_BINARY=1
	export FOX_USE_PATCHELF_BINARY=1
	export OF_OPTIONS_LIST_NUM=6
	export OF_FORCE_USE_RECOVERY_FSTAB=1
 	export OF_USE_DMCTL=1

	# For Meizu 21
	export FOX_VARIANT="Meizu_21"
	export FOX_MAINTAINER_PATCH_VERSION=$(date +%y%m%d)
	export OF_MAINTAINER="Adontoo"
	export OF_MAGISK="/tmp/misc/Magisk-v29.0.zip"
	export FOX_USE_SPECIFIC_MAGISK_ZIP=/tmp/misc/Magisk-v29.0.zip
	export OF_SCREEN_H=2340
	export OF_STATUS_H=111
	export OF_STATUS_INDENT_LEFT=10
	export OF_STATUS_INDENT_RIGHT=10
	export OF_HIDE_NOTCH=1
	export OF_ALLOW_DISABLE_NAVBAR=0

	# Make Fox theme as Black
	F=$(find "device" -name "m2461")
	\cp -fp bootable/recovery/gui/theme/portrait_hdpi/splash.xml "$F"/recovery/root/twres/splash.xml
	sed -i 's/value="#D34E38"/value="#000000"/g' "$F"/recovery/root/twres/splash.xml
	sed -i 's/value="#FF8038"/value="#000000"/g' "$F"/recovery/root/twres/splash.xml
    
	# Check if Magisk.zip exist
	if [ -f "/home/adontoo/android/Magisk-v29.0.zip" ]; then
		mkdir -p /tmp/misc
		cp -f /home/adontoo/android/Magisk-v29.0.zip /tmp/misc/Magisk-v29.0.zip
	fi
    if [ -n "$FOX_USE_SPECIFIC_MAGISK_ZIP" ]; then
    	if [ ! -f "$OF_MAGISK" ]; then
              # some colour codes
              RED='\033[0;31m'
              GREEN='\033[0;32m'
              ORANGE='\033[0;33m'
              BLUE='\033[0;34m'
              PURPLE='\033[0;35m'
              echo -e "${RED}-- File \"$OF_MAGISK\" not found  ...${NC}"
              echo -e "${ORANGE}-- Downloading...${NC}"
              wget -O /tmp/misc/Magisk-v29.0.zip https://github.com/topjohnwu/Magisk/releases/download/v29.0/Magisk-v29.0.apk
              echo -e "${BLUE}-- Successfully Downloaded the Magisk.zip File \"$OF_MAGISK\" ...${NC}"
              echo -e "${PURPLE}-- Using A Custom Magisk.zip from the Downloaded file \"$OF_MAGISK\" ...${NC}"
              echo -e "${GREEN}-- Done!"
     	fi
    fi

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi
fi
#
