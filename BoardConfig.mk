#
# Copyright (C) 2019 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/sharp/zeon_sprout

# Inherit from sharp msm8953-common
-include device/sharp/msm8953-common/BoardConfigCommon.mk

# Architecture
TARGET_CPU_VARIANT_RUNTIME := cortex-a53
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

# Assertions
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt
TARGET_OTA_ASSERT_DEVICE := zeon_sprout

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := msm8953

# Display
TARGET_SCREEN_DENSITY := 480

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)-kernel/kernel
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)-kernel/dtbo.img
endif

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2684354560
BOARD_USERDATAIMAGE_PARTITION_SIZE := 22011707392
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 268435456
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824
BOARD_FLASH_BLOCK_SIZE := 262144

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Treble
PRODUCT_FULL_TREBLE_OVERRIDE := true
PRODUCT_VENDOR_MOVE_ENABLED := true

# SELinux
SELINUX_IGNORE_NEVERALLOWS := true
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

# Inherit from the proprietary version
include vendor/sharp/zeon_sprout/BoardConfigVendor.mk
