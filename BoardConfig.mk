#
# Copyright (C) 2015 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Inherit from msm8916-common
include device/cyanogen/msm8916-common/BoardConfigCommon.mk

DEVICE_PATH := device/huawei/kiwi

TARGET_SPECIFIC_HEADER_PATH := $(DEVICE_PATH)/include

# Architecture
TARGET_BOARD_SUFFIX := _64
TARGET_USES_64_BIT_BINDER := true

# Kernel
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_SEPARATED_DT := true
BOARD_DTBTOOL_ARGS := -2
TARGET_KERNEL_SOURCE := kernel/huawei/kiwi
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CONFIG := kiwi-64_defconfig

# Assert
TARGET_OTA_ASSERT_DEVICE := kiwi

# Audio
AUDIO_FEATURE_HUAWEI_SOUND_PARAM_PATH := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth

# Bootanimation
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true

# Camera
TARGET_USES_MEDIA_EXTENSIONS := true
TARGET_NEEDS_LEGACY_CAMERA_HAL1_DYN_NATIVE_HANDLE := true
TARGET_PROCESS_SDK_VERSION_OVERRIDE := \
	/system/bin/mediaserver=23 \
	/system/vendor/bin/mm-qcamera-daemon=23

# Charger
BOARD_CHARGER_DISABLE_INIT_BLANK := true
BACKLIGHT_PATH := /sys/class/leds/lcd-backlight/brightness

# Display
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so
TARGET_SCREEN_DENSITY := 460

# Encryption
TARGET_LEGACY_HW_DISK_ENCRYPTION := true

# Extended Filesystem Support
TARGET_EXFAT_DRIVER := sdfat

# Fonts
EXCLUDE_SERIF_FONTS := true

# GPS
TARGET_GPS_HAL_PATH := $(DEVICE_PATH)/gps

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

# Keystore
TARGET_PROVIDES_KEYMASTER := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Partitions
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
# /proc/partitions * 2 * BLOCK_SIZE (512) = size in bytes
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2684354560
BOARD_USERDATAIMAGE_PARTITION_SIZE := 11618204672
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_PERSISTIMAGE_PARTITION_SIZE := 67108864
BOARD_FLASH_BLOCK_SIZE := 131072 # blockdev --getbsz /dev/block/mmcblk0p19

# Power
TARGET_TAP_TO_WAKE_NODE := /sys/touch_screen/tap_to_wake

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Qualcomm support
BOARD_USES_QC_TIME_SERVICES := true

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888

# Release
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

# RIL
TARGET_USES_OLD_MNC_FORMAT := true

# SELinux
BOARD_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy

# Shims
TARGET_LD_SHIM_LIBS := \
    /system/vendor/bin/signinfolistener|libshim_signinfolistener.so \
    /system/vendor/lib/libmmcamera_hdr_gb_lib.so|/system/vendor/lib/libmmqjpeg_codec.so \
    /system/vendor/lib/libdmd.so|libshim_cutils.so \
    /system/vendor/lib64/hw/fingerprint.msm8916.so|libshim_cutils.so \
    /system/vendor/lib64/sensors.kiwi.so|libshim_cutils.so \
    /system/vendor/lib64/libcalmodule_akm.so|libshim_cutils.so

# Vendor Init
TARGET_INIT_VENDOR_LIB := libinit_kiwi

# Vold
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun%d/file

# Wifi
TARGET_USES_WCNSS_CTRL := true
TARGET_PROVIDES_WCNSS_QMI := true

# Inherit the proprietary files
include vendor/huawei/kiwi/BoardConfigVendor.mk
