#!/bin/bash
# копирование настроек сборки
#cp_common () {                                                                                                                                                                                                                               
#    cp ./common/customize-image.sh  ./build/userpatches/
#    cp ./common/lib.config          ./build/userpatches/
#    echo "copy common"
    #копирование ПО
#    if [ -d "./build/userpatches/overlay" ]; then
#        cp -rf  ./dev/* ./build/userpatches/overlay
#    fi
#}  
#проверка была ли уже сборка 
#if [ ! -d "./build/userpatches/" ]; then
#    cp ./common/customize-image.sh  ./build/config/templates/customize-image.sh.template
#    mkdir -p ./build/userpatches/overlay
#fi
#cp_common
# сборка armbian
cd ./build/
#time sudo ./compile.sh  BOARD=radxa-zero BRANCH=current RELEASE=jammy BUILD_MINIMAL=no BUILD_DESKTOP=no KERNEL_ONLY=no KERNEL_CONFIGURE=no COMPRESS_OUTPUTIMAGE=sha,gpg,img
#    BOARD=rockpi-4b \
#    BOARD=radxa-zero \
# ========== select board
OPTION=$(whiptail --title "Menu Dialog" --menu "Choose Board" 15 60 4 \
    "1" "rockpi-4b" \
    "2" "radxa-zero" \
    "3" "bananapi" \
     3>&1 1>&2 2>&3)
exitstatus=$?
BOARD_SEL=""
if [ $exitstatus = 0 ]; then
    echo "Your chosen option:" $OPTION
else
    exit
fi
if [ $OPTION = 1 ]; then
    BOARD_SEL="rockpi-4b"
elif [ $OPTION = 2 ]; then
    BOARD_SEL="radxa-zero"
elif [ $OPTION = 3 ]; then
    BOARD_SEL="bananapi"
else
    echo "You chose Cancel."
    exit 0
fi

time ./compile.sh  BOARD=$BOARD_SEL \
    BRANCH=current RELEASE=jammy BUILD_MINIMAL=no BUILD_DESKTOP=no EXPERT=yes \
    KERNEL_ONLY=no KERNEL_CONFIGURE=no COMPRESS_OUTPUTIMAGE=sha,gpg,img USERPATCHES_PATH="../userpatches"\
    KERNEL_KEEP_CONFIG=yes EXTERNAL=yes INSTALL_HEADERS=yes 
