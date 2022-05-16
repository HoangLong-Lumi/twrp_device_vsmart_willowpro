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
FDEVICE="willowpro"
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
		export ALLOW_MISSING_DEPENDENCIES=true
		export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
		export LC_ALL="C"
		export OF_VANILLA_BUILD=1
		export OF_NO_SAMSUNG_SPECIAL=1
		export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
		export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
		export OF_DONT_PATCH_ON_FRESH_INSTALLATION=1
		export OF_SKIP_FBE_DECRYPTION=1
		export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/platform/bootdevice/by-name/recovery"

		# Extra build vars
		export FOX_REMOVE_AAPT=1
		export OF_USE_MAGISKBOOT=1
		export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
		export FOX_DISABLE_APP_MANAGER=1
		export FOX_DRASTIC_SIZE_REDUCTION=1

		# Devices
		export OF_FLASHLIGHT_ENABLE=0
		export OF_SCREEN_H=2340
		export OF_STATUS_H=60
		export OF_HIDE_NOTCH=1
		export OF_STATUS_INDENT_LEFT=48
		export OF_STATUS_INDENT_RIGHT=48
		export TARGET_DEVICE_ALT="willowpro, V341A"
		export OF_TARGET_DEVICES="willowpro"
		export OF_USE_SYSTEM_FINGERPRINT=1
		export OF_USE_TWRP_SAR_DETECT=1
		export OF_QUICK_BACKUP_LIST="/super;/boot;"
		export OF_USE_GREEN_LED=0
		export OF_SUPPORT_PRE_FLASH_SCRIPT=1

		#R11
		export FOX_R11=1
		export FOX_BUILD_TYPE=Stable
		export OF_MAINTAINER=Long266
		export FOX_VERSION="R11.1"

		# let's see what are our build VARs
		if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
		  export | grep "FOX" >> $FOX_BUILD_LOG_FILE
		  export | grep "OF_" >> $FOX_BUILD_LOG_FILE
		  export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
		  export | grep "TW_" >> $FOX_BUILD_LOG_FILE
		fi
fi
