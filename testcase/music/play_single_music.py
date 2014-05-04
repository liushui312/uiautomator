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

def runtest(serialno, loop, musicname):
    if serialno:
        from uiautomator import Device
        d = Device(serialno)
    else:
        from uiautomator import device as d

    print "总共 %d 次循环" %loop

    for i in range(1, loop+1):
        print "第 %d 次循环" %i
        d.screen.on()
        d.press.home()
        removeRecentList(d, "File Manager")
        d(description="Apps").click()
        d(text="File Manager").click()
        d(text="sdcard").click()
        d(text="Music").click()
        d(text=musicname).click()
        d(text="Google Play Music").click()
        if d(text="Just once").exists:
            d(text="Just once").click()

        for i in range(1,20):
            x = random.randint(200, 600)
            d.click(x,464)
            time.sleep(3)
        d.press.back()
        d.press.home()
        i += 1
    
    print "***** test end ********"


def main():
    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option("-l", "--loop", dest="loop", default="10",
            help="the loop count of this testcase to run [default: %default]")
    parser.add_option("-s", dest="serialno", 
            help="the device serialno")
    parser.add_option("-f", dest="musicname", 
            help="which music to play")
    (options, args) = parser.parse_args()

    runtest(options.serialno, string.atoi(options.loop), options.musicname)


if __name__ == "__main__":
    main()
