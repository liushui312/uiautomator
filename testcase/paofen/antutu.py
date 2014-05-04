#!/usr/bin/env python
#-*- coding: UTF-8 -*

import os
import sys
import time
import getopt
import string
import random
import datetime

now = datetime.datetime.now()
ISOFORMAT='%Y_%m_%d_%H_%M_%S' #设置输出格式

def removeRecentList(d, app_desc):
    d.press.home()
    d.press.recent()
    time.sleep(1)
    if d(description=app_desc).exists:
        d(description=app_desc).long_click()
        d(text="Remove from list").click()
    d.press.home()


def runtest(serialno, loop):
    print "liu: in runtest "
    if serialno:
        print "liu: in serialno"
        from uiautomator import Device
        d = Device(serialno)
    else:
        print "liu in else"
        from uiautomator import device as d

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
        j = 0
        while not d(text="Show").exists:
            time.sleep(2)
            if d(text="Unfortunately, AnTuTu Benchmark has stopped.").exists:
                print "antutu has stopped."
                sys.exit(1)
            j += 1
            if j > 100:
                d.screenshot("%s/screenshot/%d_antutu_%s.png"\
                    %(sys.path[0], i, now.strftime(ISOFORMAT)))
                sys.exit(2)
        else:
            d(text="Details").click()
            d.screenshot("%s/screenshot/%d_antutu_%s.png"\
                    %(sys.path[0], i, now.strftime(ISOFORMAT)))

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
    (options, args) = parser.parse_args()
    print "liu: before runtest"
    runtest(options.serialno, string.atoi(options.loop))

if __name__ == "__main__":
    main()
