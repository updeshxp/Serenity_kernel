#!/bin/bash
#
# Quasar Kernel Build Script 
# Coded by BlackMesa @2018
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
clear
# Init Fields
QS_V_MAJOR=2
QS_V_MINOR=0
QS_VERSION=v$QS_V_MAJOR.$QS_V_MINOR
QS_BUILD=BRA7
QS_DATE=$(date +%Y%m%d)
QS_TOOLCHAIN=/home/blackmesa/Scrivania/Android/Sorgenti/Toolchain/arm-eabi-4.9/bin/arm-eabi-
QS_JOBS=`grep processor /proc/cpuinfo|wc -l`
QS_DIR=$(pwd)
# Init Methods
CLEAN_SOURCE()
{
	make clean
	make mrproper
	rm -r -f $QS_DIR/output
}
BUILD_ZIMAGE()
{
	echo "----------------------------------------------"
	echo "Building zImage for $QS_VARIANT..."
	echo " "
	export ARCH=arm
	export CROSS_COMPILE=$QS_TOOLCHAIN
	export LOCALVERSION=-Quasar_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
	mkdir output
	make -C $QS_DIR -j$QS_JOBS O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=$QS_DEFCON SELINUX_DEFCONFIG=quasar_selinux_defconfig
	make -C $QS_DIR -j$QS_JOBS O=output
	echo " "
}
BUILD_DTB()
{
	echo "----------------------------------------------"
	echo "Building dtb for $QS_VARIANT..."
	echo " "
	$QS_DIR/tools/dtbTool -o $QS_DIR/quasar/dtb.img $QS_DIR/output/arch/arm/boot/dts/
	echo " "
}
PACK_COMMON_IMG()
{
	echo "----------------------------------------------"
	echo "Packing boot.img for $QS_VARIANT..."
	echo " "
	mkdir -p $QS_DIR/quasar/tools/aik/ramdisk
	mkdir -p $QS_DIR/quasar/tools/aik/split_img
	cp -rf $QS_DIR/quasar/ramdisk/common/ramdisk/* $QS_DIR/quasar/tools/aik/ramdisk
	cp -rf $QS_DIR/quasar/ramdisk/common/split_img/* $QS_DIR/quasar/tools/aik/split_img
	mv $QS_DIR/output/arch/arm/boot/zImage $QS_DIR/quasar/tools/aik/split_img/boot.img-zImage
	mv $QS_DIR/quasar/dtb.img $QS_DIR/quasar/tools/aik/split_img/boot.img-dtb
	$QS_DIR/quasar/tools/aik/repackimg.sh
	mv $QS_DIR/quasar/tools/aik/image-new.img $QS_DIR/quasar/build/boot-$QS_VARIANT-$QS_DATE.img
	$QS_DIR/quasar/tools/aik/cleanup.sh
}
PACK_VARIANT_IMG()
{
	echo "----------------------------------------------"
	echo "Packing boot.img for $QS_VARIANT..."
	echo " "
	mkdir -p $QS_DIR/quasar/tools/aik/ramdisk
	mkdir -p $QS_DIR/quasar/tools/aik/split_img
	cp -rf $QS_DIR/quasar/ramdisk/common/ramdisk/* $QS_DIR/quasar/tools/aik/ramdisk
	cp -rf $QS_DIR/quasar/ramdisk/common/split_img/* $QS_DIR/quasar/tools/aik/split_img
	cp -rf $QS_DIR/quasar/ramdisk/$QS_VARIANT/ramdisk/* $QS_DIR/quasar/tools/aik/ramdisk
	mv $QS_DIR/output/arch/arm/boot/zImage $QS_DIR/quasar/tools/aik/split_img/boot.img-zImage
	mv $QS_DIR/quasar/dtb.img $QS_DIR/quasar/tools/aik/split_img/boot.img-dtb
	$QS_DIR/quasar/tools/aik/repackimg.sh
	mv $QS_DIR/quasar/tools/aik/image-new.img $QS_DIR/quasar/build/boot-$QS_VARIANT-$QS_DATE.img
	$QS_DIR/quasar/tools/aik/cleanup.sh
}
PACK_A35_ZIP()
{
	echo "----------------------------------------------"
	echo "Packing flashable zip for A3 2015 kernels..."
	echo " "
	mkdir -p $QS_DIR/quasar/work
	mkdir -p $QS_DIR/quasar/work/META-INF/com/google/android
	mkdir -p $QS_DIR/quasar/work/quasar/a3ulte
	cp -f $QS_DIR/quasar/tools/flashable/binary $QS_DIR/quasar/work/META-INF/com/google/android/update-binary
	cp -f $QS_DIR/quasar/tools/flashable/a35 $QS_DIR/quasar/work/META-INF/com/google/android/updater-script
	sed -i s'/QSVER/v2.0/'g $QS_DIR/quasar/work/META-INF/com/google/android/updater-script
	cp -f $QS_DIR/quasar/tools/flashable/pronto $QS_DIR/quasar/work/quasar/pronto
	cp -f $QS_DIR/quasar/tools/flashable/wpsw $QS_DIR/quasar/work/quasar/wpsw
	mv $QS_DIR/quasar/build/boot-a3ulte-$QS_DATE.img $QS_DIR/quasar/work/quasar/a3ulte/boot.img
	cd $QS_DIR/quasar/work
	$QS_DIR/quasar/tools/flashable/zip -r -9 - * > $QS_DIR/quasar/build/Quasar_Kernel-$QS_VERSION-$QS_BUILD-A35.zip
	cd $QS_DIR
	rm -r -f $QS_DIR/quasar/work
}
PACK_A55_ZIP()
{
	echo "----------------------------------------------"
	echo "Packing flashable zip for A5 2015 kernels..."
	echo " "
	mkdir -p $QS_DIR/quasar/work
	mkdir -p $QS_DIR/quasar/work/META-INF/com/google/android
	mkdir -p $QS_DIR/quasar/work/quasar/a53g
	mkdir -p $QS_DIR/quasar/work/quasar/a5lte
	mkdir -p $QS_DIR/quasar/work/quasar/a5ltechn
	mkdir -p $QS_DIR/quasar/work/quasar/a5ulte
	mkdir -p $QS_DIR/quasar/work/quasar/a5ulte_can
	mkdir -p $QS_DIR/quasar/work/quasar/a5ulte_kor
	cp -rf $QS_DIR/quasar/tools/aik $QS_DIR/quasar/work/quasar/a5ulte
	cp -f $QS_DIR/quasar/tools/flashable/binary $QS_DIR/quasar/work/META-INF/com/google/android/update-binary
	cp -f $QS_DIR/quasar/tools/flashable/a55 $QS_DIR/quasar/work/META-INF/com/google/android/updater-script
	sed -i s'/QSVER/v2.0/'g $QS_DIR/quasar/work/META-INF/com/google/android/updater-script
	cp -f $QS_DIR/quasar/tools/flashable/pronto $QS_DIR/quasar/work/quasar/pronto
	cp -f $QS_DIR/quasar/tools/flashable/wpsw $QS_DIR/quasar/work/quasar/wpsw
	mv $QS_DIR/quasar/build/boot-a53g-$QS_DATE.img $QS_DIR/quasar/work/quasar/a53g/boot.img
	mv $QS_DIR/quasar/build/boot-a5lte-$QS_DATE.img $QS_DIR/quasar/work/quasar/a5lte/boot.img
	mv $QS_DIR/quasar/build/boot-a5ltechn-$QS_DATE.img $QS_DIR/quasar/work/quasar/a5ltechn/boot.img
	mv $QS_DIR/quasar/build/boot-a5ulte-$QS_DATE.img $QS_DIR/quasar/work/quasar/a5ulte/boot.img
	cp -f $QS_DIR/quasar/tools/flashable/dtb $QS_DIR/quasar/work/quasar/a5ulte/magic.sh
	mv $QS_DIR/quasar/dtb-can $QS_DIR/quasar/work/quasar/a5ulte_can/boot.img-dtb
	mv $QS_DIR/quasar/dtb-kor $QS_DIR/quasar/work/quasar/a5ulte_kor/boot.img-dtb
	cd $QS_DIR/quasar/work
	$QS_DIR/quasar/tools/flashable/zip -r -9 - * > $QS_DIR/quasar/build/Quasar_Kernel-$QS_VERSION-$QS_BUILD-A55.zip
	cd $QS_DIR
	rm -r -f $QS_DIR/quasar/work
}
PACK_J55_ZIP()
{
	echo "----------------------------------------------"
	echo "Packing flashable zip for J5 2015 kernels..."
	echo " "
	mkdir -p $QS_DIR/quasar/work
	mkdir -p $QS_DIR/quasar/work/META-INF/com/google/android
	mkdir -p $QS_DIR/quasar/work/quasar/j53g
	mkdir -p $QS_DIR/quasar/work/quasar/j5lte
	mkdir -p $QS_DIR/quasar/work/quasar/j5nlte
	mkdir -p $QS_DIR/quasar/work/quasar/j5ylte
	cp -f $QS_DIR/quasar/tools/flashable/binary $QS_DIR/quasar/work/META-INF/com/google/android/update-binary
	cp -f $QS_DIR/quasar/tools/flashable/j55 $QS_DIR/quasar/work/META-INF/com/google/android/updater-script
	sed -i s'/QSVER/v2.0/'g $QS_DIR/quasar/work/META-INF/com/google/android/updater-script
	cp -f $QS_DIR/quasar/tools/flashable/pronto $QS_DIR/quasar/work/quasar/pronto
	cp -f $QS_DIR/quasar/tools/flashable/wpsw $QS_DIR/quasar/work/quasar/wpsw
	mv $QS_DIR/quasar/build/boot-j53g-$QS_DATE.img $QS_DIR/quasar/work/quasar/j53g/boot.img
	mv $QS_DIR/quasar/build/boot-j5lte-$QS_DATE.img $QS_DIR/quasar/work/quasar/j5lte/boot.img
	mv $QS_DIR/quasar/build/boot-j5nlte-$QS_DATE.img $QS_DIR/quasar/work/quasar/j5nlte/boot.img
	mv $QS_DIR/quasar/build/boot-j5ylte-$QS_DATE.img $QS_DIR/quasar/work/quasar/j5ylte/boot.img
	cd $QS_DIR/quasar/work
	$QS_DIR/quasar/tools/flashable/zip -r -9 - * > $QS_DIR/quasar/build/Quasar_Kernel-$QS_VERSION-$QS_BUILD-J55.zip
	cd $QS_DIR
	rm -r -f $QS_DIR/quasar/work
}
PACK_J56_ZIP()
{
	echo "----------------------------------------------"
	echo "Packing flashable zip for J5 2016 kernels..."
	echo " "
	mkdir -p $QS_DIR/quasar/work
	mkdir -p $QS_DIR/quasar/work/META-INF/com/google/android
	mkdir -p $QS_DIR/quasar/work/quasar/j5x3g
	mkdir -p $QS_DIR/quasar/work/quasar/j5xlte
	cp -f $QS_DIR/quasar/tools/flashable/binary $QS_DIR/quasar/work/META-INF/com/google/android/update-binary
	cp -f $QS_DIR/quasar/tools/flashable/j56 $QS_DIR/quasar/work/META-INF/com/google/android/updater-script
	sed -i s'/QSVER/v2.0/'g $QS_DIR/quasar/work/META-INF/com/google/android/updater-script
	cp -f $QS_DIR/quasar/tools/flashable/pronto $QS_DIR/quasar/work/quasar/pronto
	cp -f $QS_DIR/quasar/tools/flashable/wpsw $QS_DIR/quasar/work/quasar/wpsw
	mv $QS_DIR/quasar/build/boot-j5x3g-$QS_DATE.img $QS_DIR/quasar/work/quasar/j5x3g/boot.img
	mv $QS_DIR/quasar/build/boot-j5xlte-$QS_DATE.img $QS_DIR/quasar/work/quasar/j5xlte/boot.img
	cd $QS_DIR/quasar/work
	$QS_DIR/quasar/tools/flashable/zip -r -9 - * > $QS_DIR/quasar/build/Quasar_Kernel-$QS_VERSION-$QS_BUILD-J56.zip
	cd $QS_DIR
	rm -r -f $QS_DIR/quasar/work
}
# Main Menu
clear
echo "----------------------------------------------"
echo "QuasarKernel $QS_VERSION Build Script"
echo "Coded by BlackMesa"
echo "----------------------------------------------"
PS3='Please select your option (1-18): '
menuvar=("A3 2015 (build all)" "a3ulte" "A5 2015 (build all)" "a53g" "a5lte" "a5ltechn" "a5ulte" "a5ulte_can" "a5ulte_kor" "J5 2015 (build all)" "j53g" "j5lte" "j5nlte" "j5ylte" "J5 2016 (build all)" "j5x3g" "j5xlte" "Exit")
select menuvar in "${menuvar[@]}"
do
    case $menuvar in
        "A3 2015 (build all)")
            clear
            echo "----------------------------------------------"
            echo "Starting build for all the A3 2015 variants."
            echo "Please be patient..."
            # a3ulte
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting a3ulte kernel build..."
            QS_VARIANT=a3ulte
            QS_DEFCON=quasar_msm8916_a3ulte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a3ulte kernel build finished."
            PACK_A35_ZIP
            echo " "
            echo "----------------------------------------------"
            echo "A3 2015 kernels build finished."
            echo "Flashable zip is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "a3ulte")
            clear
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting a3ulte kernel build..."
            QS_VARIANT=a3ulte
            QS_DEFCON=quasar_msm8916_a3ulte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a3ulte kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "A5 2015 (build all)")
            clear
            echo "----------------------------------------------"
            echo "Starting build for all the A5 2015 variants."
            echo "Please be patient..."
            # a53g
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting a53g kernel build..."
            QS_VARIANT=a53g
            QS_DEFCON=quasar_msm8916_a53g_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a53g kernel build finished."
            # a5lte
            echo "----------------------------------------------"
            echo "Preparing for next build..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting a5lte kernel build..."
            QS_VARIANT=a5lte
            QS_DEFCON=quasar_msm8916_a5lte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a5lte kernel build finished."
            # a5ltechn
            echo "----------------------------------------------"
            echo "Preparing for next build..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting a5ltechn kernel build..."
            QS_VARIANT=a5ltechn
            QS_DEFCON=quasar_msm8916_a5ltechn_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a5ltechn kernel build finished."
            # a5ulte
            echo "----------------------------------------------"
            echo "Preparing for next build..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting a5ulte kernel build..."
            QS_VARIANT=a5ulte
            QS_DEFCON=quasar_msm8916_a5ulte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a5ulte kernel build finished."
            # Since here we need just dtb.
            # a5ulte_can
            echo "----------------------------------------------"
            echo "Preparing for next build..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting a5ulte_can kernel build..."
            QS_VARIANT=a5ulte_can
            QS_DEFCON=quasar_msm8916_a5ulte_can_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            mv $QS_DIR/quasar/dtb.img $QS_DIR/quasar/dtb-can
            echo " "
            echo "----------------------------------------------"
            echo "a5ulte_can kernel build finished."
            # a5ulte_kor
            echo "----------------------------------------------"
            echo "Preparing for next build..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting a5ulte_kor kernel build..."
            QS_VARIANT=a5ulte_kor
            QS_DEFCON=quasar_msm8916_a5ulte_kor_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            mv $QS_DIR/quasar/dtb.img $QS_DIR/quasar/dtb-kor
            echo " "
            echo "----------------------------------------------"
            echo "a5ulte_kor kernel build finished."
            PACK_A55_ZIP
            echo " "
            echo "----------------------------------------------"
            echo "A5 2015 kernels build finished."
            echo "Flashable zip is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "a53g")
            clear
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting a53g kernel build..."
            QS_VARIANT=a53g
            QS_DEFCON=quasar_msm8916_a53g_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a53g kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "a5lte")
            clear
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting a5lte kernel build..."
            QS_VARIANT=a5lte
            QS_DEFCON=quasar_msm8916_a5lte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a5lte kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "a5ltechn")
            clear
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting a5ltechn kernel build..."
            QS_VARIANT=a5ltechn
            QS_DEFCON=quasar_msm8916_a5ltechn_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a5ltechn kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "a5ulte")
            clear
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting a5ulte kernel build..."
            QS_VARIANT=a5ulte
            QS_DEFCON=quasar_msm8916_a5ulte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a5ulte kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "a5ulte_can")
            clear
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting a5ulte_can kernel build..."
            QS_VARIANT=a5ulte_can
            QS_DEFCON=quasar_msm8916_a5ulte_can_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a5ulte_can kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "a5ulte_kor")
            clear
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting a5ulte_kor kernel build..."
            QS_VARIANT=a5ulte_kor
            QS_DEFCON=quasar_msm8916_a5ulte_kor_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a5ulte_kor kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "J5 2015 (build all)")
            clear
            echo "----------------------------------------------"
            echo "Starting build for all the J5 2015 variants."
            echo "Please be patient..."
            # j53g
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting j53g kernel build..."
            QS_VARIANT=j53g
            QS_DEFCON=quasar_msm8916_j53g_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j53g kernel build finished."
            # j5lte
            echo "----------------------------------------------"
            echo "Preparing for next build..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting j5lte kernel build..."
            QS_VARIANT=j5lte
            QS_DEFCON=quasar_msm8916_j5lte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5lte kernel build finished."
            # j5nlte
            echo "----------------------------------------------"
            echo "Preparing for next build..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting j5nlte kernel build..."
            QS_VARIANT=j5nlte
            QS_DEFCON=quasar_msm8916_j5nlte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5nlte kernel build finished."
            # j5ylte
            echo "----------------------------------------------"
            echo "Preparing for next build..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting j5ylte kernel build..."
            QS_VARIANT=j5ylte
            QS_DEFCON=quasar_msm8916_j5ylte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5ylte kernel build finished."
            PACK_J55_ZIP
            echo " "
            echo "----------------------------------------------"
            echo "J5 2015 kernels build finished."
            echo "Flashable zip is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "j53g")
            clear
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting j53g kernel build..."
            QS_VARIANT=j53g
            QS_DEFCON=quasar_msm8916_j53g_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j53g kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "j5lte")
            clear
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting j5lte kernel build..."
            QS_VARIANT=j5lte
            QS_DEFCON=quasar_msm8916_j5lte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_COMMON_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5lte kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "j5nlte")
            clear
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting j5nlte kernel build..."
            QS_VARIANT=j5nlte
            QS_DEFCON=quasar_msm8916_j5nlte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5nlte kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "j5ylte")
            clear
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting j5ylte kernel build..."
            QS_VARIANT=j5ylte
            QS_DEFCON=quasar_msm8916_j5ylte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5ylte kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "J5 2016 (build all)")
            clear
            echo "----------------------------------------------"
            echo "Starting build for all the J5 2016 variants."
            echo "Please be patient..."
            # j5x3g
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting j5x3g kernel build..."
            QS_VARIANT=j5x3g
            QS_DEFCON=quasar_msm8916_j5x3g_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5x3g kernel build finished."
            # j5xlte
            echo "----------------------------------------------"
            echo "Preparing for next build..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting j5xlte kernel build..."
            QS_VARIANT=j5xlte
            QS_DEFCON=quasar_msm8916_j5xlte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5xlte kernel build finished."
            PACK_J56_ZIP
            echo " "
            echo "----------------------------------------------"
            echo "J5 2016 kernels build finished."
            echo "Flashable zip is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "j5x3g")
            clear
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting j5x3g kernel build..."
            QS_VARIANT=j5x3g
            QS_DEFCON=quasar_msm8916_j5x3g_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5x3g kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "j5xlte")
            clear
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Starting j5xlte kernel build..."
            QS_VARIANT=j5xlte
            QS_DEFCON=quasar_msm8916_j5xlte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5xlte kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "Exit")
            break
            ;;
        *) echo Invalid option.;;
    esac
done

