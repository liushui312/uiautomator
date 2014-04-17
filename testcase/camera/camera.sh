#!/bin/bash

CUR_FILE_PATH=`dirname $0`

python $CUR_FILE_PATH/camera_back_take_pic.py -l1000
python $CUR_FILE_PATH/camera_back_video.py -l50
python $CUR_FILE_PATH/camera_back_pic_video_switch.py -l50
python $CUR_FILE_PATH/camera_front_back_switch_take_pic.py -l100
python $CUR_FILE_PATH/camera_front_back_switch_video.py -l50
python $CUR_FILE_PATH/camera_front_pic_video_switch.py -l50

