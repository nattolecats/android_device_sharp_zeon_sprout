#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=zeon_sprout
VENDOR=sharp

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils-old/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        vendor/lib/hw/camera.msm8953.so)
            sed -i "s|service.bootanim.exit|service.bootanim.hold|g" "${2}"
            ;;

        vendor/lib/libmot_gpu_mapper.so | vendor/lib/libmmcamera_vstab_module.so | vendor/lib/libmmcamera_ppeiscore.so | vendor/lib/libmmcamera2_stats_modules.so)
            sed -i "s/libgui/libwui/" "${2}"
            ;;

        vendor/lib/libmmcamera2_stats_modules.so | vendor/lib/libmmcamera_vstab_module.so)
            patchelf --remove-needed libandroid.so "${2}"
            ;;

        vendor/lib/libmmcamera2_sensor_modules.so)
            sed -i "s|/system/etc/camera/|/vendor/etc/camera/|g" "${2}"
            ;;

        vendor/bin/hw/android.hardware.biometrics.fingerprint@2.1-fpcservice)
            sed -i 's|/firmware/image|/vendor/f/image|' "${2}"
            ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
