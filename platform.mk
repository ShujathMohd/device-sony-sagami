# Copyright (C) 2014 The Android Open Source Project
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

# Platform path
PLATFORM_COMMON_PATH := device/sony/sagami

LAHAINA := sm8350

SOMC_PLATFORM := sagami
SOMC_KERNEL_VERSION := 5.4

PRODUCT_PLATFORM_SOD := true

TARGET_BOARD_PLATFORM := $(LAHAINA)

SONY_ROOT := $(PLATFORM_COMMON_PATH)/rootdir

# Overlay
DEVICE_PACKAGE_OVERLAYS += \
    $(PLATFORM_COMMON_PATH)/overlay

# RIL
TARGET_PER_MGR_ENABLED := true

TARGET_PD_SERVICE_ENABLED := true

# Wi-Fi definitions for Qualcomm solution
WIFI_DRIVER_BUILT := qca_cld3
WIFI_DRIVER_DEFAULT := qca_cld3
BOARD_HAS_QCOM_WLAN := true
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_qcwcn
BOARD_WLAN_DEVICE := qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
HOSTAPD_VERSION := VER_0_8_X
WIFI_DRIVER_FW_PATH_AP  := "ap"
WIFI_DRIVER_FW_PATH_P2P := "p2p"
WIFI_DRIVER_FW_PATH_STA := "sta"
WPA_SUPPLICANT_VERSION := VER_0_8_X
TARGET_USES_ICNSS_QMI := true
WIFI_DRIVER_STATE_CTRL_PARAM := "/sys/kernel/boot_wlan/boot_wlan"
WIFI_DRIVER_STATE_OFF := "0"
WIFI_DRIVER_STATE_ON := "1"

# BT definitions for Qualcomm solution
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
TARGET_USE_QTI_BT_STACK := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(PLATFORM_COMMON_PATH)/bluetooth
WCNSS_FILTER_USES_SIBS := true

# NFC
NXP_CHIP_FW_TYPE := PN557

# Audio
BOARD_SUPPORTS_SOUND_TRIGGER := true
AUDIO_FEATURE_ENABLED_INSTANCE_ID := true
AUDIO_FEATURE_ENABLED_HDMI_EDID := true
AUDIO_FEATURE_ENABLED_HDMI_PASSTHROUGH := true
AUDIO_FEATURE_ENABLED_DISPLAY_PORT := true
AUDIO_FEATURE_ENABLED_USB_BURST_MODE := true
AUDIO_FEATURE_SONY_CIRRUS := true
AUDIO_FEATURE_ENABLED_GKI := true

# Dynamic Partitions: Enable DP
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Display
TARGET_HAS_HDR_DISPLAY := true
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
TARGET_USES_DRM_PP := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 2

# Lights HAL: Backlight
TARGET_USES_SDE := true

# A/B support
AB_OTA_UPDATER := true
PRODUCT_SHIPPING_API_LEVEL := 27

# A/B OTA dexopt package
PRODUCT_PACKAGES += \
    otapreopt_script

# A/B OTA dexopt update_engine hookup
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# A/B related packages
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_client \
    update_engine_sideload \
    update_verifier

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot

# Dynamic Partitions: build fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Treble
# Include vndk/vndk-sp/ll-ndk modules
PRODUCT_PACKAGES += \
    vndk_package

# Device Specific Permissions
PRODUCT_COPY_FILES += \
     frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
     frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
     frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
     frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

# Audio
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/vendor/etc/sound_trigger_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_platform_info.xml \
    $(SONY_ROOT)/vendor/etc/sound_trigger_mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_mixer_paths.xml \
    $(SONY_ROOT)/vendor/etc/audio_tuning_mixer.txt:$(TARGET_COPY_OUT_VENDOR)/etc/audio_tuning_mixer.txt \
    $(SONY_ROOT)/vendor/etc/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml \
    $(SONY_ROOT)/vendor/etc/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml

# Audio - Separation between plain AOSP configuration and extended CodeAurora Audio HAL features
AUDIO_HAL_TYPE := $(if $(filter true,$(TARGET_USES_AOSP_AUDIO_HAL)),aosp,caf)
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/vendor/etc/$(AUDIO_HAL_TYPE)_common_primary_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/common_primary_audio_policy_configuration.xml

# Audio - IO policy containing audio_extn configuration
ifneq ($(TARGET_USES_AOSP_AUDIO_HAL),true)
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/vendor/etc/audio_io_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_io_policy.conf
endif

# Media
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/vendor/etc/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(SONY_ROOT)/vendor/etc/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(SONY_ROOT)/vendor/etc/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

# Qualcom WiFi Overlay
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/vendor/etc/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    $(SONY_ROOT)/vendor/etc/wifi/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf

# Qualcom WiFi Configuration
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/vendor/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini

# NFC Configuration
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/vendor/etc/libnfc-nci.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nci.conf

# Touch IDC
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/vendor/usr/idc/sec_touchscreen.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/sec_touchscreen.idc

# Keylayout
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/vendor/usr/keylayout/gpio-keys.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/gpio-keys.kl

# FPC Gestures
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/vendor/usr/idc/uinput-fpc.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/uinput-fpc.idc \
    $(SONY_ROOT)/vendor/usr/keylayout/uinput-fpc.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/uinput-fpc.kl

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/vendor/etc/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf

# RQBalance-PowerHAL configuration
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/vendor/etc/rqbalance_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/rqbalance_config.xml

# DPM config
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/vendor/etc/dpm/dpm.conf:$(TARGET_COPY_OUT_VENDOR)/etc/dpm/dpm.conf

# CAMX config
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/vendor/etc/camera/camxoverridesettings.txt:$(TARGET_COPY_OUT_VENDOR)/etc/camera/camxoverridesettings.txt

# SPU vintf
DEVICE_MANIFEST_FILE += $(PLATFORM_COMMON_PATH)/vintf/vendor.qti.spu.xml
DEVICE_MANIFEST_FILE += $(PLATFORM_COMMON_PATH)/vintf/android.hardware.authsecret_v1.0.xml

# Platform specific init
PRODUCT_PACKAGES += \
    tad.rc \
    init.sagami \
    init.sagami.pwr \
    ueventd

# Audio init
PRODUCT_PACKAGES += \
    audiopd.rc

# Audio
PRODUCT_PACKAGES += \
    sound_trigger.primary.sm8350 \
    audio.primary.sm8350 \
    libcirrusspkrprot

# Camera
PRODUCT_PACKAGES += \
    model1.dat \
    model2.dat

# GFX
PRODUCT_PACKAGES += \
    copybit.sm8350 \
    gralloc.sm8350 \
    hwcomposer.sm8350 \
    memtrack.default

# Keymaster 4 passthrough service init file
# (executable is on odm)
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.1-service-qti.rc \
    android.hardware.keymaster@4.1.vendor \
    vendor.qti.hardware.qseecom@1.0-service.rc

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.keymaster.version=v4.1 \
    ro.crypto.dm_default_key.options_format.version=2 \
    ro.crypto.volume.metadata.method=dm-default-key

DEVICE_MANIFEST_FILE += \
    $(PLATFORM_COMMON_PATH)/vintf/android.hw.keymaster_v4.1.xml \
    $(PLATFORM_COMMON_PATH)/vintf/vendor.qti.hardware.qseecom_v1.0.xml

# GPS
PRODUCT_PACKAGES += \
    gps.sm8350

# Sensors init
PRODUCT_PACKAGES += \
    sscrpcd.rc \
    sdsp-sensorspdr.rc

# Sensors
# hardware.ssc.so links against display mappers, of which
# the interface libraries are explicitly included here:
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.1-service.multihal \
    vendor.qti.hardware.display.mapper@1.1.vendor \
    vendor.qti.hardware.display.mapper@3.0.vendor

# Sensors
PRODUCT_PACKAGES += \
    sns_reg_config \
    hals.conf

# SPU
PRODUCT_PACKAGES += \
    authsecret.rc \
    spu.rc

# SSC Common config
PRODUCT_PACKAGES += \
    ak991x_dri_0.json \
    bma2x2_0.json \
    bme680_0.json \
    bmg160_0.json \
    bmp285_0.json \
    bmp380_0.json \
    bu52053nvx_0.json \
    cm3526_0.json \
    default_sensors.json \
    dps368_0.json \
    lsm6dsm_0_16g.json \
    lsm6dsm_0.json \
    lsm6dso_0_16g.json \
    lsm6dso_0.json \
    shtw2_0.json \
    sns_amd.json \
    sns_amd_sw_disabled.json \
    sns_amd_sw_enabled.json \
    sns_aont.json \
    sns_basic_gestures.json \
    sns_bring_to_ear.json \
    sns_ccd.json \
    sns_cm.json \
    sns_dae.json \
    sns_device_orient.json \
    sns_diag_filter.json \
    sns_distance_bound.json \
    sns_dpc.json \
    sns_facing.json \
    sns_fmv.json \
    sns_geomag_rv.json \
    sns_gyro_cal.json \
    sns_mag_cal.json \
    sns_multishake.json \
    sns_pedometer.json \
    sns_rmd.json \
    sns_rotv.json \
    sns_smd.json \
    sns_tilt.json \
    sns_tilt_sw_disabled.json \
    sns_tilt_sw_enabled.json \
    sns_tilt_to_wake.json \
    tmd2725.json \
    tmd3725.json \
    tmx4903.json

# Platform SSC Sensors
PRODUCT_PACKAGES += \

# Other sagami-specific sensors
PRODUCT_PACKAGES += \

# Platform-specific sensor overlays
PRODUCT_COPY_FILES += \

# CAMERA
TARGET_USES_64BIT_CAMERA := true

# Look for camera.qcom.so instead of camera.$(BOARD_TARGET_PLATFORM).so
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.camera=qcom

# QCOM Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl-qti \
    android.hardware.bluetooth@1.0-service-qti

PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.qcom.bluetooth.soc=hastings

# Legacy BT property (will be removed in S)
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.qcom.bluetooth.soc=hastings

# Audio - Android System
PRODUCT_PROPERTY_OVERRIDES += \
    aaudio.mmap_policy=2 \
    aaudio.mmap_exclusive_policy=2 \
    aaudio.hw_burst_min_usec=2000 \
    af.fast_track_multiplier=1

# Audio - QCOM HAL
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.audio.feature.concurrent_capture.enable=true \
    vendor.audio.feature.compress_in.enable=true \
    vendor.audio.feature.display_port.enable=true \
    vendor.audio.feature.hdmi_edid.enable=true \
    vendor.audio.feature.hdmi_passthrough.enable=true \
    vendor.audio.offload.buffer.size.kb=32

# Audio - QCOM proprietary
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.audio.adm.buffering.ms=2

# Audio - Sony specific
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.audio.feature.dynamic_ecns.enable=true \
    vendor.audio.enable.cirrus.speaker=true

# USB controller setup
PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.usb.dwc3=a600000.ssusb \
    sys.usb.controller=a600000.dwc3 \
    sys.usb.rndis.func.name=gsi

#WiFi MAC address path
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.wifi.addr_path=/data/vendor/wifi/wlan_mac.bin

# Display
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.display.comp_mask=0 \
    vendor.display.disable_excl_rect=0 \
    vendor.display.disable_excl_rect_partial_fb=1 \
    vendor.display.disable_hw_recovery_dump=1 \
    vendor.display.disable_layer_stitch=0 \
    vendor.display.disable_rotator_ubwc=1 \
    vendor.display.disable_scaler=0 \
    vendor.gralloc.disable_ubwc=0 \
    vendor.display.enable_posted_start_dyn=1 \
    vendor.display.enable_optimize_refresh=1 \
    vendor.display.camera_noc_efficiency_factor=0.70 \
    vendor.display.normal_noc_efficiency_factor=0.85 \
    vendor.display.secure_preview_buffer_format=420_sp \
    vendor.display.use_smooth_motion=1 \
    vendor.gralloc.secure_preview_buffer_format=420_sp \
    debug.sf.enable_advanced_sf_phase_offset=1 \
    debug.sf.high_fps_late_sf_phase_offset_ns=-5000000 \
    debug.sf.high_fps_early_phase_offset_ns=-5000000 \
    debug.sf.high_fps_early_gl_phase_offset_ns=-5000000

# Display - HDR/WCG
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.display.dataspace_saturation_matrix=1.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,1.0 \
    ro.surface_flinger.force_hwc_copy_for_virtual_displays=true \
    ro.surface_flinger.has_HDR_display=true \
    ro.surface_flinger.has_wide_color_display=true \
    ro.surface_flinger.protected_contents=true \
    ro.surface_flinger.set_touch_timer_ms=200 \
    ro.surface_flinger.use_color_management=true \
    ro.surface_flinger.wcg_composition_dataspace=143261696

# Gatekeeper
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.gatekeeper.disable_spu=true

$(call inherit-product, device/sony/common/common.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
