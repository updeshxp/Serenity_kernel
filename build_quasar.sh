#!/bin/bash
# Coded by BlackMesa @QuasarKernel v1
clear
QS_VERSION=v1
QS_DATE=$(date +%Y%m%d)
QS_TOOLCHAIN=/home/blackmesa/Scrivania/Android/Sorgenti/Toolchain/UBERTC-arm-eabi-4.8/bin/arm-eabi-
echo "------------------------------------------"
echo "QuasarKernel $QS_VERSION Build Script"
echo "Coded by BlackMesa"
echo "------------------------------------------"
PS3='Please select the kernel variant you want to build (1-4): '
options=("j53g" "j5lte" "j5nlte" "j5ylte" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "j53g")
            clear
            echo "------------------------------------------"
            echo "Building kernel for j53g..."
            echo "------------------------------------------"
            echo " "
            QS_VARIANT=j53g
            export ARCH=arm
            export CROSS_COMPILE=$QS_TOOLCHAIN
            export LOCALVERSION=-Quasar_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
            make clean
            rm -r -f output
            mkdir output
            make -C $(pwd) O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_j53g_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) O=output
            mv $(pwd)/output/arch/arm/boot/zImage $(pwd)/quasar/ramdisk/$QS_VARIANT/split_img/boot.img-zImage
            $(pwd)/tools/dtbTool -o $(pwd)/quasar/dtb.img $(pwd)/output/arch/arm/boot/dts/
            mv $(pwd)/quasar/dtb.img $(pwd)/quasar/ramdisk/$QS_VARIANT/split_img/boot.img-dtb
            $(pwd)/quasar/ramdisk/$QS_VARIANT/repackimg.sh
            mv $(pwd)/quasar/ramdisk/$QS_VARIANT/ramdisk-new.cpio.gz $(pwd)/quasar/ramdisk/$QS_VARIANT/split_img/boot.img-ramdisk.cpio.gz
            mv $(pwd)/quasar/ramdisk/$QS_VARIANT/image-new.img $(pwd)/quasar/build/boot-$QS_VARIANT-$QS_DATE.img
            echo " "
            echo "------------------------------------------"
            echo "Kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "------------------------------------------"
            read -n1 -r key
            break
            ;;
        "j5lte")
            clear
            echo "------------------------------------------"
            echo "Building kernel for j5lte..."
            echo "------------------------------------------"
            echo " "
            QS_VARIANT=j5lte
            export ARCH=arm
            export CROSS_COMPILE=$QS_TOOLCHAIN
            export LOCALVERSION=-Quasar_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
            make clean
            rm -r -f output
            mkdir output
            make -C $(pwd) O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_j5lte_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) O=output
            mv $(pwd)/output/arch/arm/boot/zImage $(pwd)/quasar/ramdisk/$QS_VARIANT/split_img/boot.img-zImage
            $(pwd)/tools/dtbTool -o $(pwd)/quasar/dtb.img $(pwd)/output/arch/arm/boot/dts/
            mv $(pwd)/quasar/dtb.img $(pwd)/quasar/ramdisk/$QS_VARIANT/split_img/boot.img-dtb
            $(pwd)/quasar/ramdisk/$QS_VARIANT/repackimg.sh
            mv $(pwd)/quasar/ramdisk/$QS_VARIANT/ramdisk-new.cpio.gz $(pwd)/quasar/ramdisk/$QS_VARIANT/split_img/boot.img-ramdisk.cpio.gz
            mv $(pwd)/quasar/ramdisk/$QS_VARIANT/image-new.img $(pwd)/quasar/build/boot-$QS_VARIANT-$QS_DATE.img
            echo " "
            echo "------------------------------------------"
            echo "Kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "------------------------------------------"
            read -n1 -r key
            break
            ;;
        "j5nlte")
            clear
            echo "------------------------------------------"
            echo "Building kernel for j5nlte..."
            echo "------------------------------------------"
            echo " "
            QS_VARIANT=j5nlte
            export ARCH=arm
            export CROSS_COMPILE=$QS_TOOLCHAIN
            export LOCALVERSION=-Quasar_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
            make clean
            rm -r -f output
            mkdir output
            make -C $(pwd) O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_j5nlte_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) O=output
            mv $(pwd)/output/arch/arm/boot/zImage $(pwd)/quasar/ramdisk/$QS_VARIANT/split_img/boot.img-zImage
            $(pwd)/tools/dtbTool -o $(pwd)/quasar/dtb.img $(pwd)/output/arch/arm/boot/dts/
            mv $(pwd)/quasar/dtb.img $(pwd)/quasar/ramdisk/$QS_VARIANT/split_img/boot.img-dtb
            $(pwd)/quasar/ramdisk/$QS_VARIANT/repackimg.sh
            mv $(pwd)/quasar/ramdisk/$QS_VARIANT/ramdisk-new.cpio.gz $(pwd)/quasar/ramdisk/$QS_VARIANT/split_img/boot.img-ramdisk.cpio.gz
            mv $(pwd)/quasar/ramdisk/$QS_VARIANT/image-new.img $(pwd)/quasar/build/boot-$QS_VARIANT-$QS_DATE.img
            echo " "
            echo "------------------------------------------"
            echo "Kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "------------------------------------------"
            read -n1 -r key
            break
            ;;
        "j5ylte")
            clear
            echo "------------------------------------------"
            echo "Building kernel for j5ylte..."
            echo "------------------------------------------"
            echo " "
            QS_VARIANT=j5ylte
            export ARCH=arm
            export CROSS_COMPILE=$QS_TOOLCHAIN
            export LOCALVERSION=-Quasar_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
            make clean
            rm -r -f output
            mkdir output
            make -C $(pwd) O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_j5ylte_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) O=output
            mv $(pwd)/output/arch/arm/boot/zImage $(pwd)/quasar/ramdisk/$QS_VARIANT/split_img/boot.img-zImage
            $(pwd)/tools/dtbTool -o $(pwd)/quasar/dtb.img $(pwd)/output/arch/arm/boot/dts/
            mv $(pwd)/quasar/dtb.img $(pwd)/quasar/ramdisk/$QS_VARIANT/split_img/boot.img-dtb
            $(pwd)/quasar/ramdisk/$QS_VARIANT/repackimg.sh
            mv $(pwd)/quasar/ramdisk/$QS_VARIANT/ramdisk-new.cpio.gz $(pwd)/quasar/ramdisk/$QS_VARIANT/split_img/boot.img-ramdisk.cpio.gz
            mv $(pwd)/quasar/ramdisk/$QS_VARIANT/image-new.img $(pwd)/quasar/build/boot-$QS_VARIANT-$QS_DATE.img
            echo " "
            echo "------------------------------------------"
            echo "Kernel build finished."
            echo "boot.img is located into quasar/build."
            echo "Press any key for end the script."
            echo "------------------------------------------"
            read -n1 -r key
            break
            ;;
        "Exit")
            break
            ;;
        *) echo Invalid option.;;
    esac
done
