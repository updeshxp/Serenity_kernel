#!/bin/bash
# Coded by BlackMesa @QuasarKernel
clear
QS_VERSION=v1.6
QS_DATE=$(date +%Y%m%d)
QS_TOOLCHAIN=/home/blackmesa/Scrivania/Android/Sorgenti/Toolchain/UBERTC-arm-eabi-4.8/bin/arm-eabi-
QS_JOBS=`grep processor /proc/cpuinfo|wc -l`
echo "------------------------------------------"
echo "QuasarKernel $QS_VERSION Build Script"
echo "Coded by BlackMesa"
echo "------------------------------------------"
PS3='Please select the kernel variant you want to build (1-12): '
options=("j53g" "j5lte" "j5nlte" "j5x3g" "j5xlte" "j5ylte" "a5lte" "a5ulte" "a5ulte_kor" "a53g" "a5ulte_can" "a5ulte_chn" "a3ulte" "Exit")
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
            make -C $(pwd) -j$QS_JOBS O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_j53g_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) -j$QS_JOBS O=output
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
            make -C $(pwd) -j$QS_JOBS O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_j5lte_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) -j$QS_JOBS O=output
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
            make -C $(pwd) -j$QS_JOBS O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_j5nlte_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) -j$QS_JOBS O=output
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
        "j5x3g")
            clear
            echo "------------------------------------------"
            echo "Building kernel for j5x3g..."
            echo "------------------------------------------"
            echo " "
            QS_VARIANT=j5x3g
            export ARCH=arm
            export CROSS_COMPILE=$QS_TOOLCHAIN
            export LOCALVERSION=-Quasar_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
            make clean
            rm -r -f output
            mkdir output
            make -C $(pwd) -j$QS_JOBS O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_j5x3g_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) -j$QS_JOBS O=output
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
        "j5xlte")
            clear
            echo "------------------------------------------"
            echo "Building kernel for j5xlte..."
            echo "------------------------------------------"
            echo " "
            QS_VARIANT=j5xlte
            export ARCH=arm
            export CROSS_COMPILE=$QS_TOOLCHAIN
            export LOCALVERSION=-Quasar_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
            make clean
            rm -r -f output
            mkdir output
            make -C $(pwd) -j$QS_JOBS O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_j5xlte_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) -j$QS_JOBS O=output
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
            make -C $(pwd) -j$QS_JOBS O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_j5ylte_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) -j$QS_JOBS O=output
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
        "a5lte")
            clear
            echo "------------------------------------------"
            echo "Building kernel for a5lte..."
            echo "------------------------------------------"
            echo " "
            QS_VARIANT=a5lte
            export ARCH=arm
            export CROSS_COMPILE=$QS_TOOLCHAIN
            export LOCALVERSION=-Quasar_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
            make clean
            rm -r -f output
            mkdir output
            make -C $(pwd) -j$QS_JOBS O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_a5lte_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) -j$QS_JOBS O=output
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
        "a5ulte")
            clear
            echo "------------------------------------------"
            echo "Building kernel for a5ulte..."
            echo "------------------------------------------"
            echo " "
            QS_VARIANT=a5ulte
            export ARCH=arm
            export CROSS_COMPILE=$QS_TOOLCHAIN
            export LOCALVERSION=-Quasar_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
            make clean
            rm -r -f output
            mkdir output
            make -C $(pwd) -j$QS_JOBS O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_a5ulte_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) -j$QS_JOBS O=output
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
        "a5ulte_kor")
            clear
            echo "------------------------------------------"
            echo "Building kernel for a5ulte_kor..."
            echo "------------------------------------------"
            echo " "
            QS_VARIANT=a5ulte_kor
            export ARCH=arm
            export CROSS_COMPILE=$QS_TOOLCHAIN
            export LOCALVERSION=-Quasar_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
            make clean
            rm -r -f output
            mkdir output
            make -C $(pwd) -j$QS_JOBS O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_a5ulte_kor_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) -j$QS_JOBS O=output
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
        "a53g")
            clear
            echo "------------------------------------------"
            echo "Building kernel for a53g..."
            echo "------------------------------------------"
            echo " "
            QS_VARIANT=a53g
            export ARCH=arm
            export CROSS_COMPILE=$QS_TOOLCHAIN
            export LOCALVERSION=-Quasar_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
            make clean
            rm -r -f output
            mkdir output
            make -C $(pwd) -j$QS_JOBS O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_a53g_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) -j$QS_JOBS O=output
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
        "a5ulte_can")
            clear
            echo "------------------------------------------"
            echo "Building kernel for a5ulte_can..."
            echo "------------------------------------------"
            echo " "
            QS_VARIANT=a5ulte_can
            export ARCH=arm
            export CROSS_COMPILE=$QS_TOOLCHAIN
            export LOCALVERSION=-Quasar_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
            make clean
            rm -r -f output
            mkdir output
            make -C $(pwd) -j$QS_JOBS O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_a5ulte_can_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) -j$QS_JOBS O=output
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
        "a5ulte_chn")
            clear
            echo "------------------------------------------"
            echo "Building kernel for a5ulte_chn..."
            echo "------------------------------------------"
            echo " "
            QS_VARIANT=a5ulte_chn
            export ARCH=arm
            export CROSS_COMPILE=$QS_TOOLCHAIN
            export LOCALVERSION=-Quasar_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
            make clean
            rm -r -f output
            mkdir output
            make -C $(pwd) -j$QS_JOBS O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_a5ulte_chn_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) -j$QS_JOBS O=output
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
        "a3ulte")
            clear
            echo "------------------------------------------"
            echo "Building kernel for a3ulte..."
            echo "------------------------------------------"
            echo " "
            QS_VARIANT=a3ulte
            export ARCH=arm
            export CROSS_COMPILE=$QS_TOOLCHAIN
            export LOCALVERSION=-Quasar_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
            make clean
            rm -r -f output
            mkdir output
            make -C $(pwd) -j$QS_JOBS O=output quasar_msm8916_defconfig VARIANT_DEFCONFIG=quasar_msm8916_a3ulte_defconfig SELINUX_DEFCONFIG=quasar_selinux_defconfig
            make -C $(pwd) -j$QS_JOBS O=output
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
