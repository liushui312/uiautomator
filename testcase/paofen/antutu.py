#!/usr/bin/env python
#-*- coding: UTF-8 -*

import os
import sys
import time
import getopt
import string
import random

def removeRecentList(d, app_desc):
    d.press.home()
    d.press.recent()
    time.sleep(1)
    if d(description=app_desc).exists:
        d(description=app_desc).long_click()
        d(text="Remove from list").click()
    d.press.home()


def runtest(serialno, loop):
    if serialno:
        from uiautomator import Device
        d = Device(serialno)
    else:
        from uiautomator import device as d

    print d.info
    print "总共 %d 次循环" %loop
    d.watcher("fail").when(text="Unfortunately, AnTuTu Benchmark has stopped.").click(text="ok")

    for i in range(1, loop+1):
        print "第 %d 次循环" %i
        d.screen.on()
        d.press.home()
        removeRecentList(d, "AnTuTu Benchmark")
        d(description="Apps").click()
        d(text="AnTuTu Benchmark").click()
        time.sleep(2)

        if d(text="Try Now").exists:
            d(text="Try Now").click()

        if d(text="Test", className="android.widget.Button").exists:
            d(text="Test", className="android.widget.Button").click()
        else:
            d(text="Test Again").click()

        d(text="Test").click()
        while not d(text="Show").exists:
            time.sleep(2)
        else:
            d(text="Details").click()
            d.screenshot("antutu_%d.png"%i)

        d.press.home()
        i += 1
    d.watchers.run()
    print "test success!"


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
