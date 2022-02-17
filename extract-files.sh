#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
#           (C) 2017-2020 The LineageOS Project
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
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=kiwi
VENDOR=huawei

# Load extractutils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

ANDROID_ROOT="$MY_DIR/../../.."

HELPER="$ANDROID_ROOT/tools/extract_utils/extract_utils.sh"
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

if [ $# -eq 0 ]; then
  SRC=adb
else
  if [ $# -eq 1 ]; then
    SRC=$1
  else
    echo "$0: bad number of arguments"
    echo ""
    echo "usage: $0 [PATH_TO_EXPANDED_ROM]"
    echo ""
    echo "If PATH_TO_EXPANDED_ROM is not specified, blobs will be extracted from"
    echo "the device using adb pull."
    exit 1
  fi
fi

function blob_fixup() {
    case "${1}" in
        vendor/lib64/hw/fingerprint.msm8916.so)
            ;&
        vendor/lib64/libcalmodule_akm.so)
            ;&
        vendor/lib64/libdmd.so)
            ;&
        vendor/lib64/libsecure_boot_keybox.so)
            ;&
        vendor/lib64/sensors.kiwi.so)
            ;&
        vendor/lib/libcalmodule_akm.so)
            ;&
        vendor/lib/libdmd.so)
            ;&
        vendor/lib/libchromatix_imx219_liteon_pad_zsl_preview.so)
            ;&
        vendor/lib/libchromatix_imx219_liteon_zsl_preview.so)
            ;&
        vendor/lib/libchromatix_imx219_ofilm_pad_zsl_preview.so)
            ;&
        vendor/lib/libchromatix_imx219_ofilm_zsl_preview.so)
            ;&
        vendor/lib/libchromatix_ov5648_foxconn_kivi_common.so)
            ;&
        vendor/lib/libchromatix_ov5648_ofilm_ohw5f03_kiw_default_video.so)
            ;&
        vendor/lib/libchromatix_ov5648_foxconn_kivi_default_video.so)
            ;&
        vendor/lib/libchromatix_ov5648_foxconn_kivi_preview.so)
            ;&
        vendor/lib/libchromatix_ov5648_ofilm_ohw5f03_kiw_common.so)
            ;&
        vendor/lib/libchromatix_ov5648_ofilm_ohw5f03_kiw_preview.so)
            ;&
        vendor/lib/libchromatix_s5k4e1_sunny_kivi_common.so)
            ;&
        vendor/lib/libchromatix_s5k4e1_sunny_kivi_default_video.so)
            ;&
        vendor/lib/libchromatix_s5k4e1_sunny_kivi_preview.so)
            ;&
        vendor/lib/libchromatix_s5k4e1_sunny_kivi_snapshot.so)
            ;&
        vendor/lib/libmmcamera_ov5648_foxconn.so)
            ;&
        vendor/lib/libmmcamera_s5k4e1_sunny.so)
            for LIBCUTILS_SHIM in $(grep -L "libshim_cutils.so" "${2}"); do
                "${PATCHELF}" --add-needed "libshim_cutils.so" "$LIBCUTILS_SHIM"
            done
            ;;
    esac
}

# Initialize the helper
setup_vendor "$DEVICE" "$VENDOR" "$ANDROID_ROOT"

extract "$MY_DIR"/proprietary-files.txt "$SRC"

"$MY_DIR"/setup-makefiles.sh
