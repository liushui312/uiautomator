#!/usr/bin/env python
#-*- coding: UTF-8 -*

import time
import sys
import getopt
import string
import random
import os

def removeRecentList(d, app_desc):
    d.press.home()
    d.press.recent()
    time.sleep(1)
    if d(description=app_desc).exists:
        d(description=app_desc).long_click()
        d(text="Remove from list").click()
    d.press.home()

def goToCtlButton(d):
    while not d(className="android.widget.SeekBar").exists:
        d.click(400,400)
        time.sleep(0.1)
    else:
        print "now in setting buttion status"

def runtest(serialno, loop, videoname):
    if serialno:
        from uiautomator import Device
        d = Device(serialno)
    else:
        from uiautomator import device as d

    print d.info
    print "总共 %d 次循环" %loop

    for i in range(1, loop+1):
        print "第 %d 次循环" %i
        d.screen.on()
        d.press.home()
        removeRecentList(d, "File Manager")
        d(description="Apps").click()
        d(text="File Manager").click()
        time.sleep(0.5)
        d(text="sdcard").click()
        d(text="Movies").click()
        print "liushui: %s"%videoname
        d(text=videoname).click()
        for i in range(1,20):
            x = random.randint(100, 600)
            d.click(x, 80)
            time.sleep(3)
        
        d.press.back()
        d.press.home()
        i += 1
    
    print "test success!"


def main():
    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option("-l", "--loop", dest="loop", default="10",
            help="the loop count of this testcase to run [default: %default]")
    parser.add_option("-s", dest="serialno", 
            help="the device serialno")
    parser.add_option("-f", dest="videname", 
            help="which video to play")
    (options, args) = parser.parse_args()

    runtest(options.serialno, string.atoi(options.loop), options.videname)


if __name__ == "__main__":
    main()
