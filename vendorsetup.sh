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
FDEVICE="x3"
#set -o xtrace

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
	export DEVICE_PATH=device/realme/x3
	export LC_ALL="C.UTF-8"
 	export ALLOW_MISSING_DEPENDENCIES=true
	export PLATFORM_VERSION=20.1.0

 	#OFR build settings & info
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	export OF_SUPPORT_OZIP_DECRYPTION=1
	export TW_OZIP_DECRYPT_KEY="0000"
	export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
	export FOX_USE_SPECIFIC_MAGISK_ZIP="$PWD/$DEVICE_PATH/magisk/Magisk.zip"
	export FOX_DELETE_INITD_ADDON=1

	#OFR binary files
	export FOX_REPLACE_BUSYBOX_PS=1
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_REPLACE_TOOLBOX_GETPROP=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export FOX_USE_SED_BINARY=1

	#OFR patches
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
	export OF_PATCH_AVB20=1
	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	export FOX_BUGGED_AOSP_ARB_WORKAROUND="1546300800"; # Tuesday, January 1, 2019 12:00:00 AM GMT+00:00 

	#OTA
	export OF_KEEP_DM_VERITY=1

	#OFR settings
	export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
	export OF_QUICK_BACKUP_LIST="/data;/boot;"
	export OF_SCREEN_H=2400
	export OF_STATUS_H=132
	export OF_STATUS_INDENT_LEFT=261
	export OF_STATUS_INDENT_RIGHT=34
	export OF_ALLOW_DISABLE_NAVBAR=0
	export OF_ADVANCED_SECURITY=1
	export OF_FLASHLIGHT_ENABLE=1
	export OF_USE_GREEN_LED=0
	export FOX_DELETE_AROMAFM=1
	export OF_ENABLE_USB_STORAGE=1
	export OF_NO_SPLASH_CHANGE=1
	export OF_HIDE_NOTCH=1

	# Unified X3 and X3 SuperZoom
	export TARGET_DEVICE_ALT="x3, RMX2081L1, RMX2085L1, RMX2086L1, RMX2083L1, RMX2082L1"

	# Maintainer
	export OF_MAINTAINER=Perses

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi
fi
#
