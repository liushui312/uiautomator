#!/bin/bash

source "common.sh"

CUR_FILE_PATH=`dirname $0`

date=`date +%F_%H-%M-%S`

echo "***** antutu.py -l1 *****"
adb shell logcat -v time -f /sdcard/antutu_${date}_logcat.log &
spid=$!
adb shell "dmesg -c > /dev/null 2>&1"
python $CUR_FILE_PATH/antutu.py -l1
ret_check
adb shell "dmesg > /sdcard/antutu_${date}_dmesg.log"
adb pull /sdcard/antutu_${date}_logcat.log $CUR_FILE_PATH/log/
adb pull /sdcard/antutu_${date}_dmesg.log $CUR_FILE_PATH/log/
kill -9 $spid
echo ""

echo "***** taiji.py -l1 *****"
adb shell logcat -v time -f /sdcard/taiji_${date}_logcat.log &
spid=$!
adb shell "dmesg -c > /dev/null 2>&1"
python $CUR_FILE_PATH/taiji.py -l1
ret_check
adb shell "dmesg > /sdcard/taiji_${date}_dmesg.log"
adb pull /sdcard/taiji_${date}_logcat.log $CUR_FILE_PATH/log/
adb pull /sdcard/taiji_${date}_dmesg.log $CUR_FILE_PATH/log/
kill -9 $spid
echo ""

echo "***** 3dmark.py -l1 *****"
adb shell logcat -v time -f /sdcard/3dmark_${date}_logcat.log &
spid=$!
adb shell "dmesg -c > /dev/null 2>&1"
python $CUR_FILE_PATH/3dmark.py -l1
ret_check
adb shell "dmesg > /sdcard/3dmark_${date}_dmesg.log"
adb pull /sdcard/3dmark_${date}_logcat.log $CUR_FILE_PATH/log/
adb pull /sdcard/3dmark_${date}_dmesg.log $CUR_FILE_PATH/log/
kill -9 $spid
echo ""

echo "***** vellamo.py -l1 *****"
adb shell logcat -v time -f /sdcard/vellamo_${date}_logcat.log &
spid=$!
adb shell "dmesg -c > /dev/null 2>&1"
python $CUR_FILE_PATH/vellamo.py -l1
ret_check
adb shell "dmesg > /sdcard/vellamo_${date}_dmesg.log"
adb pull /sdcard/vellamo_${date}_logcat.log $CUR_FILE_PATH/log/
adb pull /sdcard/vellamo_${date}_dmesg.log $CUR_FILE_PATH/log/
kill -9 $spid
echo ""
