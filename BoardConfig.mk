#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/sharp/zeon_sprout

# Inherit from common msm8953-common
include device/sharp/msm8953-common/BoardConfigCommon.mk

# Kernel
#TARGET_KERNEL_CONFIG += xiaomi/daisy.config xiaomi/sakura.config

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)-kernel/kernel
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)-kernel/dtbo.img
endif

# Filesystem
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true

# A/B
AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor

# Display
TARGET_SCREEN_DENSITY := 420

# Partitions
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2684354560
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

# Power
TARGET_TAP_TO_WAKE_NODE := "/proc/touchpanel/wakeup_gesture"

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Security Patch Level
VENDOR_SECURITY_PATCH := 2021-07-01

# Inherit from the proprietary version
include vendor/sharp/zeon_sprout/BoardConfigVendor.mk
