#
# Copyright (C) 2024 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/meizu/m2461

# Inherit from device.mk configuration
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# Release name
PRODUCT_RELEASE_NAME := meizu21

## Device identifier
PRODUCT_DEVICE := m2461
PRODUCT_NAME := twrp_m2461
PRODUCT_BRAND := meizu
PRODUCT_MODEL := Meizu 21
PRODUCT_MANUFACTURER := meizu

# Assert
TARGET_OTA_ASSERT_DEVICE := $(PRODUCT_RELEASE_NAME)

# Theme
TW_STATUS_ICONS_ALIGN := center
TW_Y_OFFSET := 111
TW_H_OFFSET := -111
