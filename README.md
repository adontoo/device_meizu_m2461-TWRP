# TWRP device tree for Meizu 21

Meizu 21Pro (codenamed _"m2461"_) is a high-end smartphone from Meizu.

It was announced & released on January 2024.

## Device specifications

Basic   | Spec Sheet
-------:|:-------------------------
SoC     | Snapdragon® 8 Gen 3 (SM8650)
CPU     | Octa-core CPU with 1x Cortex-X4 & 5x Cortex-A720 & 2x Cortex-A520
GPU     | Qualcomm® Adreno™ 750
Memory  | 8/12GB RAM (LPDDR5X)
Shipped Android Version | 14.0 with Flyme 10
Storage | 256/512GB
Battery | 4800mAh(typ), non-removable
Display | 1080x2340, 6.55", AMOLED, 1-120Hz dynamic, 1100nits peak brightness
Camera  | 200MP (main), 5MP (floating telephoto), 13MP (ultra-wide), 32MP (front)

## Features
Not works:
You tell me.

Works:
- [X] ADB
- [X] Display
- [X] Vibrator
- [X] Flashing
- [X] Sideload
- [X] Fasbootd
- [X] MTP
- [X] USB OTG
- [X] Decryption

## Build it yourself
```
mkdir twrp && cd twrp
repo init --depth=1 -u https://github.com/TWRP-Test/platform_manifest_twrp_aosp.git -b twrp-16.0
repo sync
git clone --depth=1 https://github.com/adontoo/device_meizu_m2461-TWRP device/meizu/m2461
```

Fix touch screen mapping -> [commit](https://github.com/adontoo/android_bootable_recovery_twrp-14.1/commit/262b9affa0d40ebae92c1878a69005a7269aca06)

```
source build/envsetup.sh
lunch twrp_m2461
m recoveryimage
```

If there is no error, recovery.img will be found in out/target/product/m2461/recovery.img

## How to use it

```
fastboot flash recovery_a out/target/product/m2461/recovery.img
fastboot flash recovery_b out/target/product/m2461/recovery.img
```

## Device picture

![Meizu 21Pro](https://fms.res.meizu.com/dms/2023/11/30/88f422ce-a087-46bb-88b5-6ee8dfcccea6.png)

## Donate Link(This device tree is modify from YukongA dada )
https://afdian.com/a/YuKongA
