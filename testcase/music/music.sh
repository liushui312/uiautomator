#!/bin/bash

CUR_FILE_PATH=`dirname $0`

echo "play_single_music.py -l1 -f 你把我灌醉.mp3"
python $CUR_FILE_PATH/play_single_music.py -l1 -f 你把我灌醉.mp3
echo ""

#adb install -r $CUR_FILE_PATH/kugou.apk
#python $CUR_FILE_PATH/play_mutli_video.py -l 1

