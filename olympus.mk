#
# Copyright (C) 2009 The Android Open Source Project
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

#
# This is the product configuration for a generic GSM passion,
# not specialized for any geography.
#

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

## (1) First, the most specific values, i.e. the aspects that are specific to GSM
PRODUCT_COPY_FILES += \
    device/motorola/olympus/init.mapphone_cdma.rc:root/init.mapphone_cdma.rc \
    device/motorola/olympus/init.mapphone_umts.rc:root/init.mapphone_umts.rc \
    device/motorola/olympus/ueventd.rc:root/ueventd.rc

## (2) Also get non-open-source CDMA-specific aspects if available
$(call inherit-product-if-exists, vendor/motorola/olympus/olympus-vendor.mk)

# media config xml file
PRODUCT_COPY_FILES += \
    device/motorola/olympus/media_profiles.xml:system/etc/media_profiles.xml

## (3)  Finally, the least specific parts, i.e. the non-CDMA-specific aspects

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# droid2 uses high-density artwork where available
PRODUCT_LOCALES += hdpi

# copy all kernel modules under the "modules" directory to system/lib/modules
PRODUCT_COPY_FILES += $(shell \
    find device/motorola/olympus/modules -name '*.ko' \
    | sed -r 's/^\/?(.*\/)([^/ ]+)$$/\1\2:system\/lib\/modules\/\2/' \
    | tr '\n' ' ')

ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/motorola/olympus/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

$(call inherit-product-if-exists, vendor/motorola/olympus/olympus-vendor.mk)

$(call inherit-product, build/target/product/full_base.mk)

DEVICE_PACKAGE_OVERLAYS += device/motorola/olympus/overlay

# Board-specific init
PRODUCT_COPY_FILES += \
    device/motorola/olympus/init.olympus.rc:root/init.rc \
    device/motorola/olympus/vold.fstab:system/etc/vold.fstab \
    device/motorola/olympus/gps.conf:system/etc/gps.conf \
    device/motorola/olympus/init.vsnet:system/bin/init.vsnet \
    device/motorola/olympus/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh \
    device/motorola/olympus/media_profiles.xml:system/etc/media_profiles.xml \
    device/motorola/olympus/egl.cfg:system/lib/egl/egl.cfg

#keyboard files
PRODUCT_COPY_FILES += \
    device/motorola/olympus/keylayout/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl \
    device/motorola/olympus/keychars/tegra-kbc.kcm.bin:system/usr/keychars/tegra-kbc.kcm.bin \
    device/motorola/olympus/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
    device/motorola/olympus/keylayout/usb_keyboard_102_en_us.kl:system/usr/keylayout/usb_keyboard_102_en_us.kl \
    device/motorola/olympus/keychars/usb_keyboard_102_en_us.kcm.bin:system/usr/keychars/usb_keyboard_102_en_us.kcm.bin

# Permission files
PRODUCT_COPY_FILES += \
    device/motorola/olympus/permissions/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    device/motorola/olympus/permissions/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    device/motorola/olympus/permissions/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    device/motorola/olympus/permissions/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    device/motorola/olympus/permissions/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    device/motorola/olympus/permissions/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    device/motorola/olympus/permissions/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    device/motorola/olympus/permissions/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml

PRODUCT_NAME := generic_olympus
PRODUCT_DEVICE := olympus