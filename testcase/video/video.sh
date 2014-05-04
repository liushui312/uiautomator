#!/bin/bash

CUR_FILE_PATH=`dirname $0`

adb install -r $CUR_FILE_PATH/Gallery2.apk

echo "***** play_single_video.py -l 1 -f C025_1080P_WMV2_MPEG_12M_25F.avi *****"
python $CUR_FILE_PATH/play_single_video.py -l 1 -f C025_1080P_WMV2_MPEG_12M_25F.avi
echo ""

echo "***** play_single_video.py -l 1 -f B034_720P_AVC_AC3_2M_24F.mkv *****"
python $CUR_FILE_PATH/play_single_video.py -l 1 -f B034_720P_AVC_AC3_2M_24F.mkv
echo ""

#python $CUR_FILE_PATH/play_mutli_video.py -l 1

