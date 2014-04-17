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


def runtest(serialno, loop):
    if serialno:
        from uiautomator import Device
        d = Device(serialno)
    else:
        from uiautomator import device as d

    print d.info
    print "总共 %d 次循环" %loop

    for i in range(1, loop):
        print "第 %d 次循环" %i
        d.screen.on()
        d.press.home()
        removeRecentList(d, "UHD Player")
        d(description="Apps").click()
        d(text="UHD Player").click()
        time.sleep(0.5)
        d.click(300, 520) #d.click(380,530)
        time.sleep(0.5)
        d.click(190, 210) #d.click(260,160)
        time.sleep(1)
        d.click(310, 520) #d.click(380,500)
        time.sleep(1)

        goToCtlButton(d)
        for i in range(1, 10):
            print "第 %d 次循环 in button" %i
            index = random.randint(0, 2)
            print "index: %d" %index
            d(className="android.widget.ImageButton")[index].click()
            time.sleep(2)

        d(className="android.widget.SeekBar").click()
        d.press.back()
        d.press.home()
        i += 1
    
    print "back camera take picture test success!"


def main():
    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option("-l", "--loop", dest="loop", default="10",
            help="the loop count of this testcase to run [default: %default]")
    parser.add_option("-s", dest="serialno", 
            help="the device serialno")
    (options, args) = parser.parse_args()

    runtest(options.serialno, string.atoi(options.loop))


if __name__ == "__main__":
    main()
