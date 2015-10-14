# Copyright (C) 2014 TeamEOS
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

$(call inherit-product, $(LOCAL_PATH)/product.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

PRODUCT_PACKAGES += \
        Launcher3

PRODUCT_PROPERTY_OVERRIDES += \
        net.dns1=8.8.8.8 \
        net.dns2=8.8.4.4

PRODUCT_NAME := eos_flounder
PRODUCT_DEVICE := flounder
PRODUCT_BRAND := Android
PRODUCT_MODEL := EOS on Flounder
PRODUCT_MANUFACTURER := HTC
PRODUCT_RESTRICT_VENDOR_FILES := false

$(call inherit-product, $(LOCAL_PATH)/flounder64/BoardConfig.mk)

# Kernel
KERNEL_TOOLCHAIN := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_OS)-x86/aarch64/aarch64-linux-android-4.9/bin
KERNEL_TOOLCHAIN_PREFIX := aarch64-linux-android-
TARGET_KERNEL_SOURCE := kernel/htc/flounder
TARGET_KERNEL_CONFIG := flounder_defconfig
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb

# Enable USB OTG (CAF commit to Settings)
ADDITIONAL_BUILD_PROPERTIES += \
    persist.sys.isUsbOtgEnabled=true

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=flounder \
    BUILD_FINGERPRINT=google/volantis/flounder:6.0/MRA58K/2256973:user/release-keys \
    PRIVATE_BUILD_DESC="flounder-user 6.0 MRA58K 2256973 release-keys"

# Inherit some common Eos stuff.
$(call inherit-product, vendor/eos/config/common_full_tablet_wifionly.mk)

# Copy Bootanimation
PRODUCT_COPY_FILES += \
vendor/eos/prebuilt/common/bootanimation/bootanimation.zip:system/media/bootanimation.zip
