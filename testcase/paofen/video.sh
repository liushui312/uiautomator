#!/bin/bash

CUR_FILE_PATH=`dirname $0`

python $CUR_FILE_PATH/antutu.py -l1
python $CUR_FILE_PATH/taiji.py -l1
python $CUR_FILE_PATH/3dmark.py -l1
python $CUR_FILE_PATH/vellamo.py -l1
