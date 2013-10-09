#
# Copyright (C) 2013 The Android Open-Source Project
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

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/htc/flounder-kernel/zImage-dtb
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES := \
    $(LOCAL_KERNEL):kernel \
    device/htc/flounder/init.flounder.rc:root/init.flounder.rc \
    device/htc/flounder/init.flounder.usb.rc:root/init.flounder.usb.rc \
    device/htc/flounder/fstab.flounder:root/fstab.flounder \
    device/htc/flounder/ueventd.flounder.rc:root/ueventd.flounder.rc

# Copy ardbeg files to allow booting on flounder or ardbeg for now
PRODUCT_COPY_FILES += \
    device/nvidia/ardbeg/init.ardbeg.rc:root/init.ardbeg.rc \
    device/nvidia/ardbeg/init.ardbeg.usb.rc:root/init.ardbeg.usb.rc \
    device/nvidia/ardbeg/fstab.ardbeg:root/fstab.ardbeg \
    device/nvidia/ardbeg/ueventd.ardbeg.rc:root/ueventd.ardbeg.rc \
    device/nvidia/ardbeg/raydium_ts.idc:system/usr/idc/raydium_ts.idc

PRODUCT_PACKAGES += \
    power.ardbeg \
    lights.ardbeg

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml

PRODUCT_COPY_FILES += \
    device/htc/flounder/bcmdhd.cal:system/etc/wifi/bcmdhd.cal

PRODUCT_AAPT_CONFIG := xlarge hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

PRODUCT_CHARACTERISTICS := tablet,nosdcard

DEVICE_PACKAGE_OVERLAYS := \
    device/htc/flounder/overlay

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_PACKAGES += \
    librs_jni \
    com.android.future.usb.accessory

PRODUCT_PACKAGES += \
    power.flounder \
    lights.flounder

# Filesystem management tools
PRODUCT_PACKAGES += \
    e2fsck

PRODUCT_PROPERTY_OVERRIDES := \
    wifi.interface=wlan0 \
    ro.opengles.version=196608 \
    ro.sf.lcd_density=320 \
    ro.zygote.disable_gl_preload=true \
    ro.hwui.texture_cache_size=72 \
    ro.hwui.layer_cache_size=48 \
    ro.hwui.r_buffer_cache_size=8 \
    ro.hwui.path_cache_size=32 \
    ro.hwui.gradient_cache_size=1 \
    ro.hwui.drop_shadow_cache_size=6 \
    ro.hwui.texture_cache_flushrate=0.4 \
    ro.hwui.text_small_cache_width=1024 \
    ro.hwui.text_small_cache_height=1024 \
    ro.hwui.text_large_cache_width=2048 \
    ro.hwui.text_large_cache_height=1024 \
    ro.hwui.disable_scissor_opt=true

# setup dalvik vm configs.
$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

# set default USB configuration
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# for off charging mode
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

$(call inherit-product-if-exists, hardware/nvidia/tegra124/tegra124.mk)
$(call inherit-product-if-exists, vendor/nvidia/proprietary-tegra124/tegra124-vendor.mk)
$(call inherit-product-if-exists, vendor/htc/flounder/device-vendor.mk)
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4350/device-bcm.mk)