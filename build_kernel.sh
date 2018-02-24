#!/bin/bash
clear
# Init Fields
S_V_MAJOR=1
S_V_MINOR=0
S_VERSION=v$S_V_MAJOR.$S_V_MINOR
S_BUILD=BRA7
S_DATE=$(date +%Y%m%d)
S_TOOLCHAIN=/home/updeshsr/linaro/bin/arm-eabi-
S_JOBS=`grep processor /proc/cpuinfo|wc -l`
S_DIR=$(pwd)
# Init Methods
CLEAN_SOURCE()
{
	make clean
	make mrproper
	rm -r -f $S_DIR/output
}
BUILD_ZIMAGE()
{
	echo "----------------------------------------------"
	echo "Building zImage for $S_VARIANT..."
	echo " "
	export ARCH=arm
	export CROSS_COMPILE=$S_TOOLCHAIN
	export LOCALVERSION=-Serenity_Kernel-$S_VERSION-$S_VARIANT-$S_DATE
	mkdir output
	make -C $S_DIR -j$S_JOBS O=output serenity_msm8916_defconfig VARIANT_DEFCONFIG=$S_DEFCON SELINUX_DEFCONFIG=serenity_selinux_defconfig
	make -C $S_DIR -j$S_JOBS O=output
	echo " "
}
BUILD_DTB()
{
	echo "----------------------------------------------"
	echo "Building dtb for $S_VARIANT..."
	echo " "
	$S_DIR/tools/dtbTool -o $S_DIR/serenity/dtb.img $S_DIR/output/arch/arm/boot/dts/
	echo " "
}
PACK_COMMON_IMG()
{
	echo "----------------------------------------------"
	echo "Packing boot.img for $S_VARIANT..."
	echo " "
	mkdir -p $S_DIR/serenity/tools/aik/ramdisk
	mkdir -p $S_DIR/serenity/tools/aik/split_img
	cp -rf $S_DIR/serenity/ramdisk/common/ramdisk/* $S_DIR/serenity/tools/aik/ramdisk
	cp -rf $S_DIR/serenity/ramdisk/common/split_img/* $S_DIR/serenity/tools/aik/split_img
	mv $S_DIR/output/arch/arm/boot/zImage $S_DIR/serenity/tools/aik/split_img/boot.img-zImage
	mv $S_DIR/serenity/dtb.img $S_DIR/serenity/tools/aik/split_img/boot.img-dtb
	$S_DIR/serenity/tools/aik/repackimg.sh
	mv $S_DIR/serenity/tools/aik/image-new.img $S_DIR/serenity/build/boot-$S_VARIANT-$S_DATE.img
	$S_DIR/serenity/tools/aik/cleanup.sh
}
PACK_VARIANT_IMG()
{
	echo "----------------------------------------------"
	echo "Packing boot.img for $S_VARIANT..."
	echo " "
	mkdir -p $S_DIR/serenity/tools/aik/ramdisk
	mkdir -p $S_DIR/serenity/tools/aik/split_img
	cp -rf $S_DIR/serenity/ramdisk/common/ramdisk/* $S_DIR/serenity/tools/aik/ramdisk
	cp -rf $S_DIR/serenity/ramdisk/common/split_img/* $S_DIR/serenity/tools/aik/split_img
	cp -rf $S_DIR/serenity/ramdisk/$S_VARIANT/ramdisk/* $S_DIR/serenity/tools/aik/ramdisk
	mv $S_DIR/output/arch/arm/boot/zImage $S_DIR/serenity/tools/aik/split_img/boot.img-zImage
	mv $S_DIR/serenity/dtb.img $S_DIR/serenity/tools/aik/split_img/boot.img-dtb
	$S_DIR/serenity/tools/aik/repackimg.sh
	mv $S_DIR/serenity/tools/aik/image-new.img $S_DIR/serenity/build/boot-$S_VARIANT-$S_DATE.img
	$S_DIR/serenity/tools/aik/cleanup.sh
}
PACK_A35_ZIP()
{
	echo "----------------------------------------------"
	echo "Packing flashable zip for A3 2015 kernels..."
	echo " "
	mkdir -p $S_DIR/serenity/work
	mkdir -p $S_DIR/serenity/work/META-INF/com/google/android
	mkdir -p $S_DIR/serenity/work/serenity/a3ulte
	cp -f $S_DIR/serenity/tools/flashable/binary $S_DIR/serenity/work/META-INF/com/google/android/update-binary
	cp -f $S_DIR/serenity/tools/flashable/a35 $S_DIR/serenity/work/META-INF/com/google/android/updater-script
	sed -i s'/QSVER/v2.0/'g $S_DIR/serenity/work/META-INF/com/google/android/updater-script
	cp -f $S_DIR/serenity/tools/flashable/pronto $S_DIR/serenity/work/serenity/pronto
	cp -f $S_DIR/serenity/tools/flashable/wpsw $S_DIR/serenity/work/serenity/wpsw
	mv $S_DIR/serenity/build/boot-a3ulte-$S_DATE.img $S_DIR/serenity/work/serenity/a3ulte/boot.img
	cd $S_DIR/serenity/work
	$S_DIR/serenity/tools/flashable/zip -r -9 - * > $S_DIR/serenity/build/Serenity_Kernel-$S_VERSION-$S_BUILD-A35.zip
	cd $S_DIR
	rm -r -f $S_DIR/serenity/work
}
PACK_A55_ZIP()
{
	echo "----------------------------------------------"
	echo "Packing flashable zip for A5 2015 kernels..."
	echo " "
	mkdir -p $S_DIR/serenity/work
	mkdir -p $S_DIR/serenity/work/META-INF/com/google/android
	mkdir -p $S_DIR/serenity/work/serenity/a53g
	mkdir -p $S_DIR/serenity/work/serenity/a5lte
	mkdir -p $S_DIR/serenity/work/serenity/a5ltechn
	mkdir -p $S_DIR/serenity/work/serenity/a5ulte
	mkdir -p $S_DIR/serenity/work/serenity/a5ulte_can
	mkdir -p $S_DIR/serenity/work/serenity/a5ulte_kor
	cp -rf $S_DIR/serenity/tools/aik $S_DIR/serenity/work/serenity/a5ulte
	cp -f $S_DIR/serenity/tools/flashable/binary $S_DIR/serenity/work/META-INF/com/google/android/update-binary
	cp -f $S_DIR/serenity/tools/flashable/a55 $S_DIR/serenity/work/META-INF/com/google/android/updater-script
	sed -i s'/QSVER/v2.0/'g $S_DIR/serenity/work/META-INF/com/google/android/updater-script
	cp -f $S_DIR/serenity/tools/flashable/pronto $S_DIR/serenity/work/serenity/pronto
	cp -f $S_DIR/serenity/tools/flashable/wpsw $S_DIR/serenity/work/serenity/wpsw
	mv $S_DIR/serenity/build/boot-a53g-$S_DATE.img $S_DIR/serenity/work/serenity/a53g/boot.img
	mv $S_DIR/serenity/build/boot-a5lte-$S_DATE.img $S_DIR/serenity/work/serenity/a5lte/boot.img
	mv $S_DIR/serenity/build/boot-a5ltechn-$S_DATE.img $S_DIR/serenity/work/serenity/a5ltechn/boot.img
	mv $S_DIR/serenity/build/boot-a5ulte-$S_DATE.img $S_DIR/serenity/work/serenity/a5ulte/boot.img
	cp -f $S_DIR/serenity/tools/flashable/dtb $S_DIR/serenity/work/serenity/a5ulte/magic.sh
	mv $S_DIR/serenity/dtb-can $S_DIR/serenity/work/serenity/a5ulte_can/boot.img-dtb
	mv $S_DIR/serenity/dtb-kor $S_DIR/serenity/work/serenity/a5ulte_kor/boot.img-dtb
	cd $S_DIR/serenity/work
	$S_DIR/serenity/tools/flashable/zip -r -9 - * > $S_DIR/serenity/build/Serenity_Kernel-$S_VERSION-$S_BUILD-A55.zip
	cd $S_DIR
	rm -r -f $S_DIR/serenity/work
}
PACK_J55_ZIP()
{
	echo "----------------------------------------------"
	echo "Packing flashable zip for J5 2015 kernels..."
	echo " "
	mkdir -p $S_DIR/serenity/work
	mkdir -p $S_DIR/serenity/work/META-INF/com/google/android
	mkdir -p $S_DIR/serenity/work/serenity/j53g
	mkdir -p $S_DIR/serenity/work/serenity/j5lte
	mkdir -p $S_DIR/serenity/work/serenity/j5nlte
	mkdir -p $S_DIR/serenity/work/serenity/j5ylte
	cp -f $S_DIR/serenity/tools/flashable/binary $S_DIR/serenity/work/META-INF/com/google/android/update-binary
	cp -f $S_DIR/serenity/tools/flashable/j55 $S_DIR/serenity/work/META-INF/com/google/android/updater-script
	sed -i s'/QSVER/v2.0/'g $S_DIR/serenity/work/META-INF/com/google/android/updater-script
	cp -f $S_DIR/serenity/tools/flashable/pronto $S_DIR/serenity/work/serenity/pronto
	cp -f $S_DIR/serenity/tools/flashable/wpsw $S_DIR/serenity/work/serenity/wpsw
	mv $S_DIR/serenity/build/boot-j53g-$S_DATE.img $S_DIR/serenity/work/serenity/j53g/boot.img
	mv $S_DIR/serenity/build/boot-j5lte-$S_DATE.img $S_DIR/serenity/work/serenity/j5lte/boot.img
	mv $S_DIR/serenity/build/boot-j5nlte-$S_DATE.img $S_DIR/serenity/work/serenity/j5nlte/boot.img
	mv $S_DIR/serenity/build/boot-j5ylte-$S_DATE.img $S_DIR/serenity/work/serenity/j5ylte/boot.img
	cd $S_DIR/serenity/work
	$S_DIR/serenity/tools/flashable/zip -r -9 - * > $S_DIR/serenity/build/Serenity_Kernel-$S_VERSION-$S_BUILD-J55.zip
	cd $S_DIR
	rm -r -f $S_DIR/serenity/work
}
PACK_J56_ZIP()
{
	echo "----------------------------------------------"
	echo "Packing flashable zip for J5 2016 kernels..."
	echo " "
	mkdir -p $S_DIR/serenity/work
	mkdir -p $S_DIR/serenity/work/META-INF/com/google/android
	mkdir -p $S_DIR/serenity/work/serenity/j5x3g
	mkdir -p $S_DIR/serenity/work/serenity/j5xlte
	cp -f $S_DIR/serenity/tools/flashable/binary $S_DIR/serenity/work/META-INF/com/google/android/update-binary
	cp -f $S_DIR/serenity/tools/flashable/j56 $S_DIR/serenity/work/META-INF/com/google/android/updater-script
	sed -i s'/QSVER/v2.0/'g $S_DIR/serenity/work/META-INF/com/google/android/updater-script
	cp -f $S_DIR/serenity/tools/flashable/pronto $S_DIR/serenity/work/serenity/pronto
	cp -f $S_DIR/serenity/tools/flashable/wpsw $S_DIR/serenity/work/serenity/wpsw
	mv $S_DIR/serenity/build/boot-j5x3g-$S_DATE.img $S_DIR/serenity/work/serenity/j5x3g/boot.img
	mv $S_DIR/serenity/build/boot-j5xlte-$S_DATE.img $S_DIR/serenity/work/serenity/j5xlte/boot.img
	cd $S_DIR/serenity/work
	$S_DIR/serenity/tools/flashable/zip -r -9 - * > $S_DIR/serenity/build/Serenity_Kernel-$S_VERSION-$S_BUILD-J56.zip
	cd $S_DIR
	rm -r -f $S_DIR/serenity/work
}
# Main Menu
clear
echo "----------------------------------------------"
echo "SerenityKernel $S_VERSION Build Script"
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
            S_VARIANT=a3ulte
            S_DEFCON=serenity_msm8916_a3ulte_defconfig
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
            echo "Flashable zip is located into serenity/build."
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
            S_VARIANT=a3ulte
            S_DEFCON=serenity_msm8916_a3ulte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a3ulte kernel build finished."
            echo "boot.img is located into serenity/build."
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
            S_VARIANT=a53g
            S_DEFCON=serenity_msm8916_a53g_defconfig
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
            S_VARIANT=a5lte
            S_DEFCON=serenity_msm8916_a5lte_defconfig
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
            S_VARIANT=a5ltechn
            S_DEFCON=serenity_msm8916_a5ltechn_defconfig
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
            S_VARIANT=a5ulte
            S_DEFCON=serenity_msm8916_a5ulte_defconfig
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
            S_VARIANT=a5ulte_can
            S_DEFCON=serenity_msm8916_a5ulte_can_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            mv $S_DIR/serenity/dtb.img $S_DIR/serenity/dtb-can
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
            S_VARIANT=a5ulte_kor
            S_DEFCON=serenity_msm8916_a5ulte_kor_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            mv $S_DIR/serenity/dtb.img $S_DIR/serenity/dtb-kor
            echo " "
            echo "----------------------------------------------"
            echo "a5ulte_kor kernel build finished."
            PACK_A55_ZIP
            echo " "
            echo "----------------------------------------------"
            echo "A5 2015 kernels build finished."
            echo "Flashable zip is located into serenity/build."
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
            S_VARIANT=a53g
            S_DEFCON=serenity_msm8916_a53g_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a53g kernel build finished."
            echo "boot.img is located into serenity/build."
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
            S_VARIANT=a5lte
            S_DEFCON=serenity_msm8916_a5lte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a5lte kernel build finished."
            echo "boot.img is located into serenity/build."
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
            S_VARIANT=a5ltechn
            S_DEFCON=serenity_msm8916_a5ltechn_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a5ltechn kernel build finished."
            echo "boot.img is located into serenity/build."
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
            S_VARIANT=a5ulte
            S_DEFCON=serenity_msm8916_a5ulte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a5ulte kernel build finished."
            echo "boot.img is located into serenity/build."
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
            S_VARIANT=a5ulte_can
            S_DEFCON=serenity_msm8916_a5ulte_can_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a5ulte_can kernel build finished."
            echo "boot.img is located into serenity/build."
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
            S_VARIANT=a5ulte_kor
            S_DEFCON=serenity_msm8916_a5ulte_kor_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "a5ulte_kor kernel build finished."
            echo "boot.img is located into serenity/build."
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
            S_VARIANT=j53g
            S_DEFCON=serenity_msm8916_j53g_defconfig
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
            S_VARIANT=j5lte
            S_DEFCON=serenity_msm8916_j5lte_defconfig
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
            S_VARIANT=j5nlte
            S_DEFCON=serenity_msm8916_j5nlte_defconfig
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
            S_VARIANT=j5ylte
            S_DEFCON=serenity_msm8916_j5ylte_defconfig
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
            echo "Flashable zip is located into serenity/build."
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
            S_VARIANT=j53g
            S_DEFCON=serenity_msm8916_j53g_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j53g kernel build finished."
            echo "boot.img is located into serenity/build."
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
            S_VARIANT=j5lte
            S_DEFCON=serenity_msm8916_j5lte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_COMMON_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5lte kernel build finished."
            echo "boot.img is located into serenity/build."
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
            S_VARIANT=j5nlte
            S_DEFCON=serenity_msm8916_j5nlte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5nlte kernel build finished."
            echo "boot.img is located into serenity/build."
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
            S_VARIANT=j5ylte
            S_DEFCON=serenity_msm8916_j5ylte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5ylte kernel build finished."
            echo "boot.img is located into serenity/build."
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
            S_VARIANT=j5x3g
            S_DEFCON=serenity_msm8916_j5x3g_defconfig
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
            S_VARIANT=j5xlte
            S_DEFCON=serenity_msm8916_j5xlte_defconfig
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
            echo "Flashable zip is located into serenity/build."
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
            S_VARIANT=j5x3g
            S_DEFCON=serenity_msm8916_j5x3g_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5x3g kernel build finished."
            echo "boot.img is located into serenity/build."
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
            S_VARIANT=j5xlte
            S_DEFCON=serenity_msm8916_j5xlte_defconfig
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_VARIANT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "j5xlte kernel build finished."
            echo "boot.img is located into serenity/build."
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

