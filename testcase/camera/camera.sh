#!/bin/bash

source "common.sh"

CUR_FILE_PATH=`dirname $0`

date=`date +%F_%H-%M-%S`

echo "***** camera_back_take_pic.py -l1000 *****"
adb shell logcat -v time -f /sdcard/camera_back_take_pic_${date}_logcat.log &
spid=$!
adb shell "dmesg -c > /dev/null 2>&1"
python $CUR_FILE_PATH/camera_back_take_pic.py -l1000
ret_check
adb shell "dmesg > /sdcard/camera_back_take_pic_${date}_dmesg.log"
adb pull /sdcard/camera_back_take_pic_${date}_logcat.log $CUR_FILE_PATH/log/
adb pull /sdcard/camera_back_take_pic_${date}_dmesg.log $CUR_FILE_PATH/log/
kill -9 $spid
echo ""

echo "***** camera_back_video.py -l50 *****"
adb shell logcat -v time -f /sdcard/camera_back_video_${date}_logcat.log &
spid=$!
adb shell "dmesg -c > /dev/null 2>&1"
python $CUR_FILE_PATH/camera_back_video.py -l50
ret_check
adb shell "dmesg > /sdcard/camera_back_video_${date}_dmesg.log"
adb pull /sdcard/camera_back_video_${date}_logcat.log $CUR_FILE_PATH/log/
adb pull /sdcard/camera_back_video_${date}_dmesg.log $CUR_FILE_PATH/log/
kill -9 $spid
echo ""


echo "***** camera_back_pic_video_switch.py -l50 *****"
adb shell logcat -v time -f /sdcard/camera_back_pic_video_switch_${date}_logcat.log &
spid=$!
adb shell "dmesg -c > /dev/null 2>&1"
python $CUR_FILE_PATH/camera_back_pic_video_switch.py -l50
ret_check
adb shell "dmesg > /sdcard/camera_back_pic_video_switch_${date}_dmesg.log"
adb pull /sdcard/camera_back_pic_video_switch_${date}_logcat.log $CUR_FILE_PATH/log/
adb pull /sdcard/camera_back_pic_video_switch_${date}_dmesg.log $CUR_FILE_PATH/log/
kill -9 $spid
echo ""


echo "***** camera_front_back_switch_take_pic.py -l100 *****"
adb shell logcat -v time -f /sdcard/camera_front_back_switch_take_pic_${date}_logcat.log &
spid=$!
adb shell "dmesg -c > /dev/null 2>&1"
python $CUR_FILE_PATH/camera_front_back_switch_take_pic.py -l100
ret_check
adb shell "dmesg > /sdcard/camera_front_back_switch_take_pic_${date}_dmesg.log"
adb pull /sdcard/camera_front_back_switch_take_pic_${date}_logcat.log $CUR_FILE_PATH/log/
adb pull /sdcard/camera_front_back_switch_take_pic_${date}_dmesg.log $CUR_FILE_PATH/log/
kill -9 $spid
echo ""


echo "***** camera_front_back_switch_video.py -l50 *****"
adb shell logcat -v time -f /sdcard/camera_front_back_switch_video_${date}_logcat.log &
spid=$!
adb shell "dmesg -c > /dev/null 2>&1"
python $CUR_FILE_PATH/camera_front_back_switch_video.py -l50
ret_check
adb shell "dmesg > /sdcard/camera_front_back_switch_video_${date}_dmesg.log"
adb pull /sdcard/camera_front_back_switch_video_${date}_logcat.log $CUR_FILE_PATH/log/
adb pull /sdcard/camera_front_back_switch_video_${date}_dmesg.log $CUR_FILE_PATH/log/
kill -9 $spid
echo ""


echo "***** camera_front_pic_video_switch.py -l50 *****"
adb shell logcat -v time -f /sdcard/camera_front_pic_video_switch_${date}_logcat.log &
spid=$!
adb shell "dmesg -c > /dev/null 2>&1"
python $CUR_FILE_PATH/camera_front_pic_video_switch.py -l50
ret_check
adb shell "dmesg > /sdcard/camera_front_pic_video_switch_${date}_dmesg.log"
adb pull /sdcard/camera_front_pic_video_switch_${date}_logcat.log $CUR_FILE_PATH/log/
adb pull /sdcard/camera_front_pic_video_switch_${date}_dmesg.log $CUR_FILE_PATH/log/
kill -9 $spid
echo ""

