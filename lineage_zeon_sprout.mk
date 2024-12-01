# Inherit some common Lineage stuff
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Device
$(call inherit-product, device/sharp/zeon_sprout/device.mk)

PRODUCT_BRAND := SG
PRODUCT_DEVICE := zeon_sprout
PRODUCT_MANUFACTURER := SHARP
PRODUCT_MODEL := S5-SH
PRODUCT_NAME := lineage_zeon_sprout

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="S5-user 11 S2014 03.00.00 release-keys" \
    BuildFingerprint=SG/S5/zeon_sprout:11/S2014/03.00.00:user/release-keys \
    DeviceProduct=zeon_sprout
